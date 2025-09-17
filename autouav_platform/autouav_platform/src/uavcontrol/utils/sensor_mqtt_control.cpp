#include "sensor_mqtt_control.h"
#include "sensor_mqtt_state.h"
#include <mavros_msgs/CommandLong.h>
#include <fstream>
#include <thread>
#include <random>
#include <sys/wait.h>
#include <cstring>
#include <csignal>

using namespace std;
const std::string VOLUME_GAIN = "20dB";

// GPIO控制器实现
GPIOCtrl::GPIOCtrl(int gpio_pin) : pin(gpio_pin), is_exported(false) {  // 显式初始化is_exported
    exportGPIO();       // 导出GPIO
    setDirection("out");  //
    digitalWrite(false);  // 初始化为低电平
}

GPIOCtrl::~GPIOCtrl() {
    if (is_exported) unexportGPIO();  // 释放GPIO
}

void GPIOCtrl::digitalWrite(bool state) {
    // 写入GPIO值（注意：根据硬件设计，可能需要反转逻辑）
    const char val = state ? '1' : '0';
    ofstream value_file("/sys/class/gpio/gpio" + to_string(pin) + "/value");
    if (value_file.is_open()) {
        value_file << val;
    } else {
        ROS_ERROR("Can not open GPIO File");
    }
}

void GPIOCtrl::exportGPIO() {
    // 导出GPIO
    ofstream export_file("/sys/class/gpio/export");
    if (export_file.is_open()) {
        export_file << pin;
        export_file.close();
        this_thread::sleep_for(chrono::milliseconds(100));  // 等待导出完成
        is_exported = true;
    } else {
        throw runtime_error("Failed to export GPIO " + to_string(pin));
    }
}

void GPIOCtrl::unexportGPIO() {
    // 释放GPIO
    ofstream unexport_file("/sys/class/gpio/unexport");
    if (unexport_file.is_open()) {
        unexport_file << pin;
    }
}

void GPIOCtrl::setDirection(const string& direction) {
    // 设置GPIO方向
    ofstream dir_file("/sys/class/gpio/gpio" + to_string(pin) + "/direction");
    if (dir_file.is_open()) {
        dir_file << direction;
    } else {
        throw runtime_error("Failed to set GPIO direction");
    }
}

// PWM控制器实现
// PWMCtrl::PWMCtrl(ros::NodeHandle& nh, int channel) 
//     : channel(channel), nh(nh) {
//     // 初始化MAVROS命令服务客户端
//     command_client = nh.serviceClient<mavros_msgs::CommandLong>("uav2/mavros/cmd/command");
//     ros::service::waitForService("uav2/mavros/cmd/command", ros::Duration(5));
//     ROS_INFO("PWM tunnel %d control initialed finished", channel);
// }

// PWMCtrl::~PWMCtrl() {
//     disable();  // 禁用PWM输出
// }

// void PWMCtrl::setPWMValue(int pwm_value) {
//     // 设置PWM值（范围：1000-1600微秒）
//     pwm_value = max(1000, min(1600, pwm_value));
    
//     // 构建MAVROS命令
//     mavros_msgs::CommandLong cmd;
//     cmd.request.broadcast = false;
//     cmd.request.command = 183; // MAV_CMD_DO_SET_SERVO
//     cmd.request.param1 = channel;
//     cmd.request.param2 = pwm_value;
    
//     // 调用服务发送命令
//     if(command_client.call(cmd)) {
//         if(cmd.response.success) {
//             ROS_INFO("PWM tunnel %d set  %d us success", channel, pwm_value);
//         } else {
//             ROS_ERROR("PWM tunnel  %d set failed，error code: %d", channel, cmd.response.result);
//         }
//     } else {
//         ROS_ERROR("excute service  uav2/mavros/cmd/command failed");
//     }
// }

// void PWMCtrl::enable() {
//     setPWMValue(1000);  // 启用PWM（min值）
// }

// void PWMCtrl::disable() {
//     setPWMValue(1600);  // 禁用PWM（最max值）
// }

// PWM(GPIO)

PWMCtrl::PWMCtrl(int gpio_pin) : pin(gpio_pin) {
    // chu shi hua zhan kong bi wei 0, zhou qi wei 50 HZ
    string cmd_dual_cycle = "gpio pwm " + to_string(pin) + " 0";
    int dual_cycle_set = system(cmd_dual_cycle.c_str());
    string cmd_pwmtone = "gpio pwmTone " + to_string(pin) + " 50";
    int result_pwmtone = system(cmd_pwmtone.c_str());
    if (dual_cycle_set == 0 && result_pwmtone == 0){
        ROS_INFO("PWM %d Initialied Success!",pin);
    } 
    // string cmd = "gpio mode " + to_string(pin) + " pwm";
    // int result = system(cmd.c_str());
    // if (result != 0) {
    //     ROS_ERROR("SET PWM %d mode failed", pin);
    // }
    
    // 初始化为低电平
    // cmd = "gpio pwm " + to_string(pin) + " 0";
    // result = system(cmd.c_str());
    // if (result != 0) {
    //     ROS_ERROR("初始化GPIO %d 电平失败", pin);
    // }
    
    ROS_INFO("PWM 通道 GPIO %d 初始化完成", pin);
}

PWMCtrl::~PWMCtrl(){
    // 禁用PWM输出
    disable();
    
    // 可选：将GPIO设置为输入模式以释放
    string cmd = "gpio pwm " + to_string(pin) + " 0";
    string cmd_gpio = "gpio mode " + to_string(pin) + " in";
    string cmd_gpio_1 = "gpio write " + to_string(pin) + " 1";
    system(cmd.c_str());
    system(cmd_gpio.c_str());
    system(cmd_gpio_1.c_str());
}

void PWMCtrl::setPWMValue(int pwm_value){
    // string cmd_pwmtone = "gpio pwmTone " + to_string(pin) + " 100";

    // int result = system(cmd.c_str());
    // if (result != 0) {
    //     ROS_ERROR("SET PWM %d mode failed", pin);
    // }
    // pwm_value = max(1000, min(1600, pwm_value));

    // bool state = (pwm_value > 1300);
    // string cmd = "gpio write " + to_string(pin) + " " + (state ? "1" : "0");
    string cmd = "gpio pwm " + to_string(pin) + " " + to_string(pwm_value);
    string cmd_pwm = "gpio mode " + to_string(pin) + " pwm";
    int result_pwm = system(cmd_pwm.c_str());
    int result = system(cmd.c_str());
    // int result_pwmtone = system(cmd_pwmtone.c_str());

    
    
    if (result == 0 && result_pwm ==0 ) {
        // ROS_INFO("GPIO %d has set to %d us -> %s", pin, pwm_value, state ? "HIGH" : "LOW");
        ROS_INFO("GPIO %d has set to %d us", pin, pwm_value);
    } else {
        ROS_ERROR("set  %d pwm failed", pin);
    }
}

void PWMCtrl::enable(int pwm_value){
    // if(dual_cycle == "Medium"){
        setPWMValue(pwm_value);
    // }
    // else if(dual_cycle == "High"){
    //     setPWMValue(500);
    // }
    
}

// void PWMCtrl::setMedium(){
//     setPWMValue(250);
// }

// void PWMCtrl::setHigh(){
//     setPWMValue(500);
// }

void PWMCtrl::disable(){
    setPWMValue(200);
}

void PWMCtrl::digitalWrite(bool state){
    string cmd = "gpio write " + to_string(pin) + " " + (state ? "1" : "0");
    int result = system(cmd.c_str());
    
    if (result != 0) {
        ROS_ERROR("GPIO %d 写入失败", pin);
    }
}

void PWMCtrl::exportGPIO() {
    // 使用gpio命令会自动处理export，无需单独实现
}

void PWMCtrl::unexportGPIO() {
    // 使用gpio命令会自动处理，无需单独实现
}

void PWMCtrl::setDirection(const string& direction) {
    string cmd = "gpio mode " + to_string(pin) + " " + direction;
    int result = system(cmd.c_str());
    
    if (result != 0) {
        ROS_ERROR("设置GPIO %d 方向失败", pin);
    }
}


// 控制设备管理器实现
ControlDeviceManager::ControlDeviceManager(
    const string& broker,
    const string& username,
    const string& password,
    const string& pub_topic,
    const string& sub_topic,
    const string& stream_url,
    ros::NodeHandle& nh,
    StatePublisherManager& state_manager,
    int parachute_gpio,
    int police)
    : nh_(nh),
      state_manager(state_manager),
      mqtt_broker(broker),
      mqtt_user(username),
      mqtt_password(password),
      mqtt_pub_topic(pub_topic),
      mqtt_sub_topic(sub_topic),
      searchlight_gpio(111), //led_gpio
      police_relay(police),
      STREAM_URL(stream_url),
      audio_pgid(-1) {  // 初始化进程组ID
    
    // 初始化PWM控制器AUX5-AUX8（通道5-为抛投，9通道为降落伞）
//     pwm_controllers.resize(5);
//     for (int i = 0; i < 5; ++i) {
//         pwm_controllers[i] = make_unique<PWMCtrl>(nh, i + 9);  // 5、6、7、8通道（AUX5-8）
//     }
//    // 降落伞通道：AUX9（通道9）→ 逻辑通道5（索引4）
//    pwm_controllers[4] = make_unique<PWMCtrl>(nh, parachute_pwm);  // 正确索引4，需传入9作为parachute_pwm

    pwm_controllers.resize(5);
    pwm_controllers[0] = make_unique<PWMCtrl>(0); // pwm1 -> GPIO16 physical id 3  pwmchip1
    pwm_controllers[1] = make_unique<PWMCtrl>(1); // pwm2 -> GPIO15 physical id 5  pwmchip0
    pwm_controllers[2] = make_unique<PWMCtrl>(2); // pwm3 -> GPIO62 physical id 7  pwmchip4
    pwm_controllers[3] = make_unique<PWMCtrl>(22); // pwm4 -> GPIO114 physical id 33
    pwm_controllers[4] = make_unique<PWMCtrl>(parachute_gpio); // 降落伞 -> 指定GPIO

    // 优化SIGCHLD处理
    struct sigaction sa;
    sa.sa_handler = SIG_DFL;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGCHLD, &sa, NULL) == -1) {
        ROS_ERROR("设置SIGCHLD处理程序失败: %s", strerror(errno));
    }

    // 初始化MQTT客户端
    initMQTT();
     
}

// 初始化MQTT（补充实现，原代码缺失）
void ControlDeviceManager::initMQTT() {
    // 生成唯一客户端ID
    random_device rd;
    string client_id = "uav_control_" + to_string(rd());
    
    mqtt_client = make_unique<mqtt::async_client>(mqtt_broker, client_id);
    mqtt_client->set_callback(*this);
    
    mqtt::connect_options opts;
    opts.set_keep_alive_interval(60);
    opts.set_clean_session(true);
    if (!mqtt_user.empty() && !mqtt_password.empty()) {
        opts.set_user_name(mqtt_user);
        opts.set_password(mqtt_password);
    }
    
    try {
        mqtt_client->connect(opts)->wait();
        mqtt_client->subscribe(mqtt_sub_topic, 1)->wait();
        ROS_INFO("Control MQTT connect success（subscribe topic: %s）", mqtt_sub_topic.c_str());
    } catch (const mqtt::exception& e) {
        throw runtime_error("Control MQTT initialized failed: " + string(e.what()));
    }
}


void ControlDeviceManager::wait_for_connection() {
    // 等待MQTT连接建立（依赖状态管理器的连接）
    state_manager.waitForConnection(); 
}

// MQTT连接丢失回调（补充实现）
void ControlDeviceManager::connection_lost(const string& cause) {
    ROS_WARN("Control MQTT connection lost: %s", cause.c_str());
    is_connected = false;
    
    // 启动重连线程
    thread([this]() {
        int retries = 0;
        while (!is_connected) {
            int delay = min(60, (1 << retries));  // 指数退避
            this_thread::sleep_for(chrono::seconds(delay));
            try {
                mqtt_client->connect()->wait();
                mqtt_client->subscribe(mqtt_sub_topic, 1)->wait();
                is_connected = true;
                ROS_INFO("Control MQTT reconnect success");
            } catch (const exception& e) {
                ROS_WARN("Control MQTT reconnect failed（%d次）: %s", retries, e.what());
                retries++;
            }
        }
    }).detach();
}

// MQTT消息接收回调（补充实现）
void ControlDeviceManager::message_arrived(mqtt::const_message_ptr msg) {
    string payload = msg->get_payload_str();
    ROS_INFO("Receive control instructions: %s", payload.c_str());
    
    try {
        json j = json::parse(payload);
        processCommand(j);
    } catch (const json::exception& e) {
        ROS_ERROR("Instruction parsing failed: %s", e.what());
    }
}

// MQTT消息发送完成回调（补充实现）
void ControlDeviceManager::delivery_complete(mqtt::delivery_token_ptr token) {
    if (token) {
        ROS_DEBUG("Control message send finished: %s", token->get_message()->get_topic().c_str());
    }
}

ControlDeviceManager::~ControlDeviceManager() {
    // 清理资源
    if (mqtt_client && mqtt_client->is_connected()) {
        mqtt_client->disconnect()->wait();
    }
    
    if (audio_pgid != -1) {
        stopAudioStream();
    }
    
    // 禁用所有PWM通道
    for (auto& ctrl : pwm_controllers) {
        ctrl->disable();
    }
}

void ControlDeviceManager::processCommand(const json& j) {
    try {
        const auto& cmd = j["command"];
        
        // 处理探照灯命令
        if (cmd.contains("led")) {
            setLedState(cmd["led"].get<bool>());
        }
        
        // 处理喊话器命令
        if (cmd.contains("shout")) {
            setShoutState(cmd["shout"].get<bool>());
        }
                
        // 处理降落伞命令
        if (cmd.contains("parachute")) {
            setPWMState(5, cmd["parachute"].get<bool>());
        }

        // 处理警灯命令
        if (cmd.contains("police")) {
            setPoliceState(cmd["police"].get<bool>());
        } 
        
        // 处理左侧抛投器命令
        if (cmd.contains("left")) {
            const auto& left = cmd["left"];
            
            if (left.contains("pwm1")) {
                setPWMState(1, left["pwm1"].get<bool>());
            }
            
            if (left.contains("pwm2")) {
                setPWMState(2, left["pwm2"].get<bool>());
            }
        }

        // 处理右侧抛投器命令
        if (cmd.contains("right")) {
            const auto& right = cmd["right"];
            
            if (right.contains("pwm3")) {
                setPWMState(3, right["pwm3"].get<bool>());
            }
            
            if (right.contains("pwm4")) {
                setPWMState(4, right["pwm4"].get<bool>());
            }
        }        
    } catch (const json::exception& e) {
        ROS_ERROR("Instruction parsing failed: %s", e.what());
    }
}

void ControlDeviceManager::setLedState(bool new_state) {
    // 设置探照灯状态
    searchlight_gpio.digitalWrite(new_state);
    
    // 更新状态并发布
    UAVState partialUpdate;
    partialUpdate.led_state = new_state;
    state_manager.updateStatePartial(partialUpdate);
    
    ROS_INFO("The searchlight status is set to : %s", new_state ? "open" : "close");
}

void ControlDeviceManager::setShoutState(bool new_state) {
    // 设置喊话器状态（避免重复操作）
    if (new_state == (audio_pgid != -1)) return;
    
    if (new_state) {
        startAudioStream();
    } else {
        stopAudioStream();
    }
    
    // 更新状态并发布
    UAVState partialUpdate;
    partialUpdate.shout_state = new_state;
    state_manager.updateStatePartial(partialUpdate);
    
    ROS_INFO("The shouter audio stream statue is set to: %s", new_state ? "open" : "close");
}

void ControlDeviceManager::setPWMState(int channel, bool new_state) {
    // 设置PWM通道状态（参数校验）
    if (channel < 1 || channel > 5) {
        ROS_ERROR("Invalid PWM tunnel: %d", channel);
        return;
    }
    
    // 控制PWM硬件
    // if (new_state) {
    //     if (channel == 5) {  // 降落伞通道使用特殊值
    //         pwm_controllers[channel-1]->setPWMValue(1600);
    //     } else {
    //         pwm_controllers[channel-1]->enable();
    //     }
    // } else {
    //     if (channel == 5) {  // 降落伞通道使用特殊值
    //         pwm_controllers[channel-1]->setPWMValue(1000);
    //     } else {
    //         pwm_controllers[channel-1]->disable();
    //     }
    // }

    if (new_state) {
        // int pwm_value = (dual_cycle == "High") ? 450 : 200; 
        pwm_controllers[channel-1]->enable(300);  // 450
    } else {
        pwm_controllers[channel-1]->disable(); // 10
    }
    
    // 更新状态并发布
    UAVState partialUpdate;
    switch(channel) {
        case 1: partialUpdate.pwm1_state = new_state; break;
        case 2: partialUpdate.pwm2_state = new_state; break;
        case 3: partialUpdate.pwm3_state = new_state; break;
        case 4: partialUpdate.pwm4_state = new_state; break;
        case 5: partialUpdate.parachute_state = new_state; break;
    }
    
    state_manager.updateStatePartial(partialUpdate);
    ROS_INFO("PWM tunnel %d state has set to : %s", channel, new_state ? "open" : "close");
}

void ControlDeviceManager::setPoliceState(bool new_state) {
    // 设置警灯状态
    police_relay.digitalWrite(new_state);
    
    // 更新状态并发布
    UAVState partialUpdate;
    partialUpdate.police_state = new_state;
    state_manager.updateStatePartial(partialUpdate);
    
    ROS_INFO("The police Light statue is set to: %s", new_state ? "open" : "close");
}

// 在ControlDeviceManager类的private成员中添加：
int audio_pipe[2];  // 用于进程间通信的管道，监控子进程状态

// 启动音频流（优化版）
void ControlDeviceManager::startAudioStream() {
    lock_guard<mutex> lock(audio_mutex);
    if (audio_pgid != -1) return;

    // 创建管道（用于监控子进程状态）
    if (pipe(audio_pipe) == -1) {
        ROS_ERROR("创建管道失败: %s", strerror(errno));
        return;
    }

    // 优化ffmpeg命令：添加-re确保实时输出，避免数据堆积
    // string command = "ffmpeg -loglevel warning -re -fflags +genpts -i \"" + STREAM_URL + "\" "
    //                 "-f s16le -acodec pcm_s16le -ar 44100 -ac 2 - | "
    //                 "aplay -f S16_LE -r 44100 -c 2";
    std::string command = "ffmpeg -loglevel verbose -i \"" + STREAM_URL + "\" "
                     "-af \"volume=" + VOLUME_GAIN + "\" "
                    "-f s16le -acodec pcm_s16le -ar 44100 -ac 2 - | "
                    "/usr/bin/aplay -f S16_LE -r 44100 -c 2";

    ROS_INFO("启动喊话器音频流: %s", command.c_str());

    pid_t pid = fork();
    if (pid < 0) {
        ROS_ERROR("fork失败: %s", strerror(errno));
        close(audio_pipe[0]);
        close(audio_pipe[1]);
        return;
    }

    if (pid == 0) {  // 子进程
        close(audio_pipe[0]);  // 关闭读端
        setpgid(0, 0);
        execl("/bin/sh", "sh", "-c", command.c_str(), (char*)NULL);
        // 若execl失败，通过管道通知父进程
        int err = errno;
        write(audio_pipe[1], &err, sizeof(err));
        close(audio_pipe[1]);
        _exit(1);
    } else {  // 父进程
        close(audio_pipe[1]);  // 关闭写端
        audio_pgid = pid;

        // 启动监控线程：检测子进程是否异常退出
        thread([this]() {
            int err;
            ssize_t n = read(audio_pipe[0], &err, sizeof(err));
            close(audio_pipe[0]);
            if (n > 0) {
                ROS_ERROR("音频流子进程启动失败: %s", strerror(err));
                lock_guard<mutex> lock(audio_mutex);
                audio_pgid = -1;
            } else if (n == 0) {
                ROS_DEBUG("音频流子进程正常退出");
            }
        }).detach();

        ROS_INFO("音频流已启动，进程组ID: %d", audio_pgid);
    }
}

// 停止音频流（优化版）
void ControlDeviceManager::stopAudioStream() {
    lock_guard<mutex> lock(audio_mutex);
    if (audio_pgid == -1) return;

    ROS_INFO("停止喊话器音频流，进程组ID: %d", audio_pgid);

    // 步骤1：先终止aplay（读取端），避免管道读取方提前退出导致写入错误
    system("pkill -f aplay");
    this_thread::sleep_for(chrono::milliseconds(200));  // 等待aplay退出

    // 步骤2：再终止ffmpeg（写入端）
    if (kill(-audio_pgid, SIGTERM) < 0) {
        ROS_ERROR("发送终止信号失败: %s", strerror(errno));
    } else {
        this_thread::sleep_for(chrono::milliseconds(300));
        if (kill(-audio_pgid, 0) == 0) {
            ROS_WARN("强制终止音频流进程组");
            kill(-audio_pgid, SIGKILL);
        }
    }

    // 步骤3：清理子进程，忽略无关错误
    int status;
    waitpid(audio_pgid, &status, WNOHANG);

    audio_pgid = -1;
    ROS_INFO("音频流已停止");
}
