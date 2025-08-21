#pragma once

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#include <chrono>
#include <cstring>
#include <map>
#include <mutex>
#include <optional>
#include <string>
#include <thread>
#include <utility>
#include <vector>

namespace gimbal {

class UDPConnectionManager {
public:
  UDPConnectionManager() { startCleanupThread(); }
  ~UDPConnectionManager() { closeAll(); }

  int getConnection(const std::string& local_ip, uint16_t local_port) {
    std::lock_guard<std::mutex> lock(mutex_);
    const auto key = std::make_pair(local_ip, local_port);

    auto it = sockets_.find(key);
    if (it != sockets_.end()) {
      last_used_[key] = std::chrono::steady_clock::now();
      return it->second;
    }

    // Create socket
    int fd = ::socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0) {
      throw std::runtime_error("Failed to create UDP socket");
    }

    int opt = 1;
    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(local_port);
    addr.sin_addr.s_addr = local_ip.empty() ? htonl(INADDR_ANY) : inet_addr(local_ip.c_str());

    if (::bind(fd, reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) < 0) {
      // If port busy, bind ephemeral
      addr.sin_port = htons(0);
      if (::bind(fd, reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) < 0) {
        ::close(fd);
        throw std::runtime_error("Failed to bind UDP socket");
      }
    }

    sockets_[key] = fd;
    last_used_[key] = std::chrono::steady_clock::now();
    return fd;
  }

  bool sendPacket(const std::vector<uint8_t>& packet,
                  const std::string& target_ip,
                  uint16_t target_port,
                  const std::string& local_ip,
                  uint16_t local_port) {
    try {
      const int fd = getConnection(local_ip, local_port);

      sockaddr_in to{};
      to.sin_family = AF_INET;
      to.sin_port = htons(target_port);
      to.sin_addr.s_addr = inet_addr(target_ip.c_str());

      ssize_t n = ::sendto(fd, packet.data(), packet.size(), 0,
                           reinterpret_cast<sockaddr*>(&to), sizeof(to));
      return n == static_cast<ssize_t>(packet.size());
    } catch (...) {
      return false;
    }
  }

  void closeAll() {
    running_ = false;
    if (cleanup_thread_.joinable()) cleanup_thread_.join();

    std::lock_guard<std::mutex> lock(mutex_);
    for (auto& kv : sockets_) {
      ::close(kv.second);
    }
    sockets_.clear();
    last_used_.clear();
  }

private:
  void startCleanupThread() {
    running_ = true;
    cleanup_thread_ = std::thread([this]() {
      const auto timeout = std::chrono::seconds(30);
      while (running_) {
        {
          std::lock_guard<std::mutex> lock(mutex_);
          const auto now = std::chrono::steady_clock::now();
          std::vector<std::pair<std::string, uint16_t>> expired;
          for (const auto& kv : last_used_) {
            if (now - kv.second > timeout) {
              expired.push_back(kv.first);
            }
          }
          for (const auto& key : expired) {
            auto it = sockets_.find(key);
            if (it != sockets_.end()) {
              ::close(it->second);
              sockets_.erase(it);
            }
            last_used_.erase(key);
          }
        }
        std::this_thread::sleep_for(std::chrono::seconds(5));
      }
    });
  }

  std::map<std::pair<std::string, uint16_t>, int> sockets_;
  std::map<std::pair<std::string, uint16_t>, std::chrono::steady_clock::time_point> last_used_;
  std::mutex mutex_;
  bool running_ = false;
  std::thread cleanup_thread_;
};

}  // namespace gimbal 