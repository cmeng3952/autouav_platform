#pragma once

#include <array>
#include <cstdint>
#include <cstring>
#include <vector>
#include <stdexcept>

namespace gimbal {

// CRC16 per Python nibble-table algorithm (init 0x0000, poly 0x1021), big-endian placement at bytes 70-71 over first 70 bytes
inline uint16_t calculate_crc16_ibm(const uint8_t* data, size_t length) {
  static const uint16_t crc_ta[16] = {
      0x0000, 0x1021, 0x2042, 0x3063,
      0x4084, 0x50A5, 0x60C6, 0x70E7,
      0x8108, 0x9129, 0xA14A, 0xB16B,
      0xC18C, 0xD1AD, 0xE1CE, 0xF1EF};
  uint16_t crc = 0x0000;
  for (size_t i = 0; i < length; ++i) {
    uint8_t byte = data[i];
    uint16_t da = crc >> 12;
    crc = static_cast<uint16_t>((crc << 4) & 0xFFFF);
    crc ^= crc_ta[da ^ (byte >> 4)];
    da = crc >> 12;
    crc = static_cast<uint16_t>((crc << 4) & 0xFFFF);
    crc ^= crc_ta[da ^ (byte & 0x0F)];
  }
  return crc;
}

class GCUPacketBuilder {
public:
  static constexpr uint16_t HEADER = 0xA8E5;
  static constexpr uint16_t PACKET_LENGTH = 72;
  static constexpr uint8_t PROTOCOL_VERSION = 0x02;

  // Control mode
  static constexpr uint8_t MODE_ANGLE = 0x10;  // angle control
  static constexpr uint8_t MODE_RATE = 0x11;   // rate control

  // Aircraft/navigation optional fields
  float aircraft_roll_deg = 0.0f;
  float aircraft_pitch_deg = 0.0f;
  float aircraft_yaw_deg = 0.0f;
  float aircraft_north_acc = 0.0f;
  float aircraft_east_acc = 0.0f;
  float aircraft_up_acc = 0.0f;
  float aircraft_north_vel = 0.0f;
  float aircraft_east_vel = 0.0f;
  float aircraft_up_vel = 0.0f;

  // GNSS payload (subframe)
  double longitude_deg = 0.0;   // scaled by 1e7
  double latitude_deg = 0.0;    // scaled by 1e7
  double altitude_m = 0.0;      // scaled by 1e3
  uint8_t satellite_count = 0;
  uint32_t gnss_ms = 0;
  uint16_t gnss_week = 0;
  double relative_height_m = 0.0; // scaled by 1e3

  // Whether control fields are valid
  bool control_valid = true;

  std::array<uint8_t, PACKET_LENGTH> buildAngleControlPacket(float pitch_deg, float yaw_deg, float roll_deg) const {
    std::array<uint8_t, PACKET_LENGTH> pkt{};

    // 0-1 header
    pkt[0] = 0xA8; pkt[1] = 0xE5;

    // 2-3 length (little-endian)
    pkt[2] = static_cast<uint8_t>(PACKET_LENGTH & 0xFF);
    pkt[3] = static_cast<uint8_t>((PACKET_LENGTH >> 8) & 0xFF);

    // 4 version
    pkt[4] = PROTOCOL_VERSION;

    // 5-6 roll expected Euler angle (deg*100) little-endian int16
    write_le<int16_t>(&pkt[5], static_cast<int16_t>(roll_deg * 100.0f));

    // 7-8 pitch expected Euler angle (deg*100) little-endian int16
    write_le<int16_t>(&pkt[7], static_cast<int16_t>(pitch_deg * 100.0f));

    // 9-10 yaw expected relative angle (deg*100) little-endian int16
    write_le<int16_t>(&pkt[9], static_cast<int16_t>(yaw_deg * 100.0f));

    // 11 flags: control valid + aircraft INS valid => 0x05 when valid
    pkt[11] = control_valid ? 0x05 : 0x00;

    // 12-17 aircraft absolute attitude (deg*100)
    write_le<int16_t>(&pkt[12], static_cast<int16_t>(aircraft_roll_deg * 100.0f));
    write_le<int16_t>(&pkt[14], static_cast<int16_t>(aircraft_pitch_deg * 100.0f));
    write_le<int16_t>(&pkt[16], static_cast<int16_t>(aircraft_yaw_deg * 100.0f));

    // 18-29 aircraft accelerations/velocities (scaled*100)
    write_le<int16_t>(&pkt[18], static_cast<int16_t>(aircraft_north_acc * 100.0f));
    write_le<int16_t>(&pkt[20], static_cast<int16_t>(aircraft_east_acc * 100.0f));
    write_le<int16_t>(&pkt[22], static_cast<int16_t>(aircraft_up_acc * 100.0f));
    write_le<int16_t>(&pkt[24], static_cast<int16_t>(aircraft_north_vel * 100.0f));
    write_le<int16_t>(&pkt[26], static_cast<int16_t>(aircraft_east_vel * 100.0f));
    write_le<int16_t>(&pkt[28], static_cast<int16_t>(aircraft_up_vel * 100.0f));

    // 30 subframe request code
    pkt[30] = 0x01;

    // 31-36 reserved -> 0

    // 37 subframe header
    pkt[37] = 0x01;

    // 38-41 longitude * 1e7, 42-45 latitude * 1e7, 46-49 altitude * 1e3 (all little-endian int32)
    write_le<int32_t>(&pkt[38], static_cast<int32_t>(longitude_deg * 10000000.0));
    write_le<int32_t>(&pkt[42], static_cast<int32_t>(latitude_deg * 10000000.0));
    write_le<int32_t>(&pkt[46], static_cast<int32_t>(altitude_m * 1000.0));

    // 50 satellites
    pkt[50] = satellite_count;

    // 51-54 GNSS ms (uint32), 55-56 GNSS week (uint16)
    write_le<uint32_t>(&pkt[51], gnss_ms);
    write_le<uint16_t>(&pkt[55], gnss_week);

    // 57-60 relative height * 1e3 (int32 LE)
    write_le<int32_t>(&pkt[57], static_cast<int32_t>(relative_height_m * 1000.0));

    // 61-68 reserved

    // 69 command: angle control
    pkt[69] = 0x10;

    // 70-71 CRC big-endian over first 70 bytes
    const uint16_t crc = calculate_crc16_ibm(pkt.data(), 70);
    pkt[70] = static_cast<uint8_t>((crc >> 8) & 0xFF);
    pkt[71] = static_cast<uint8_t>(crc & 0xFF);

    return pkt;
  }

  std::array<uint8_t, PACKET_LENGTH> buildCenterPacket() const {
    std::array<uint8_t, PACKET_LENGTH> pkt{};

    pkt[0] = 0xA8; pkt[1] = 0xE5;
    pkt[2] = static_cast<uint8_t>(PACKET_LENGTH & 0xFF);
    pkt[3] = static_cast<uint8_t>((PACKET_LENGTH >> 8) & 0xFF);
    pkt[4] = PROTOCOL_VERSION;

    // 11 flags for center: set control invalid (0x00)
    pkt[11] = 0x00;

    // 30 request code, 37 subframe header
    pkt[30] = 0x01;
    pkt[37] = 0x01;

    // 69 command: center
    pkt[69] = 0x03;

    const uint16_t crc = calculate_crc16_ibm(pkt.data(), 70);
    pkt[70] = static_cast<uint8_t>((crc >> 8) & 0xFF);
    pkt[71] = static_cast<uint8_t>(crc & 0xFF);

    return pkt;
  }

  std::array<uint8_t, PACKET_LENGTH> buildModeSwitchPacket(uint8_t mode) const {
    auto pkt = buildAngleControlPacket(0.0f, 0.0f, 0.0f);
    pkt[69] = mode;
    const uint16_t crc = calculate_crc16_ibm(pkt.data(), 70);
    pkt[70] = static_cast<uint8_t>((crc >> 8) & 0xFF);
    pkt[71] = static_cast<uint8_t>(crc & 0xFF);
    return pkt;
  }

  static bool validatePacketFormat(const std::vector<uint8_t>& pkt) {
    if (pkt.size() != PACKET_LENGTH) return false;
    if (pkt[0] != 0xA8 || pkt[1] != 0xE5) return false;
    const uint16_t len = static_cast<uint16_t>(pkt[2]) | (static_cast<uint16_t>(pkt[3]) << 8);
    if (len != PACKET_LENGTH) return false;
    if (pkt[4] != PROTOCOL_VERSION) return false;
    const uint16_t recv_crc = static_cast<uint16_t>(pkt[70] << 8) | pkt[71];
    const uint16_t calc_crc = calculate_crc16_ibm(pkt.data(), 70);
    return recv_crc == calc_crc;
  }

private:
  template <typename T>
  static void write_le(uint8_t* dst, T value) {
    for (size_t i = 0; i < sizeof(T); ++i) {
      dst[i] = static_cast<uint8_t>((static_cast<uint64_t>(value) >> (8 * i)) & 0xFF);
    }
  }
};

} // namespace gimbal 