# UAV Control Package

UAV Control Package 是一个基于ROS的无人机控制系统，提供完整的飞行控制、状态估计、任务规划和通信功能。

## 包结构

```
uavcontrol/
├── include/                    # 头文件目录
│   ├── uav_controller.h       # 主控制器类
│   ├── uav_estimator.h        # 状态估计器类
│   ├── mission_waypoint.h     # 任务航点控制
│   ├── aruco_land.h          # ArUco码定位降落
│   ├── usr_mqtt.hpp          # MQTT通信接口
│   ├── rc_input.h            # 遥控器输入处理
│   ├── Filter/               # 滤波器
│   │   ├── HighPassFilter.h
│   │   ├── LowPassFilter.h
│   │   └── LeadLagFilter.h
│   └── Position_Controller/   # 位置控制器
│       ├── pos_controller_PID.h
│       ├── pos_controller_UDE.h
│       ├── pos_controller_NE.h
│       └── controller_utils.h
├── src/                      # 源代码目录
│   ├── uav_control_node.cpp  # 主控制节点
│   ├── uav_controller.cpp    # 控制器实现
│   ├── uav_estimator_node.cpp # 状态估计节点
│   └── uav_estimator.cpp     # 状态估计器实现
├── utils/                    # 工具节点
│   ├── uav_command_pub.cpp   # 命令发布器
│   ├── mission_planner.cpp   # 任务规划器
│   ├── mission_waypoint.cpp  # 航点控制器
│   ├── aruco_land.cpp       # ArUco降落
│   ├── joy_node.cpp         # 手柄控制
│   ├── Led_mqtt_bridge.cpp  # LED MQTT桥接
│   └── uavstate_mqtt_bridge.cpp # 状态MQTT桥接
├── launch/                   # 启动文件
│   ├── px4.launch           # PX4飞控连接
│   ├── uav_outdor_control.launch # 室外控制
│   ├── uav_indor_control.launch  # 室内控制
│   ├── mission_planning.launch   # 任务规划
│   └── aruco_land.launch    # ArUco降落
├── config/                   # 配置文件
│   ├── uav_control.yaml     # 主配置文件
│   ├── mqtt_command.json    # MQTT命令格式
│   └── sensor_tf_offset.yaml # 传感器外参
└── sh/                      # 脚本文件
    ├── mission_planning_with_controller.sh
    ├── uav_outdor_control.sh
    └── uav_indor_control.sh
```

## 核心功能模块

### 1. 飞行控制器 (UAV Controller)

**主要类**: `UAV_controller`

**功能特性**:
- 多模式飞行控制 (RC控制、指令控制、任务控制)
- 多种位置控制器支持 (PX4原生、PID、UDE、NE)
- 地理围栏保护
- 自动起飞/降落
- 紧急返航功能
- PX4参数动态配置

**控制模式**:
```cpp
enum CONTROL_STATE
{
    INIT = 0,               // 初始模式      
    RC_POS_CONTROL = 1,     // 悬停状态
    COMMAND_CONTROL = 2,    // 指令控制
    LAND_CONTROL = 3        // 降落
};
```

**位置控制器类型**:
```cpp
enum POS_CONTOLLER
{
    PX4_ORIGIN = 0, // PX4原生的控制算法
    PID = 1,        // PID算法
    UDE = 2,        // UDE算法
    NE = 3          // NE算法
};
```

### 2. 状态估计器 (UAV Estimator)

**主要类**: `UAV_estimator`

**功能特性**:
- 多传感器数据融合
- 支持多种定位源
- 实时状态估计
- 轨迹记录和可视化
- 传感器外参补偿

**支持的定位源**:
- MOCAP (光学动捕)
- T265 (Intel RealSense)
- GAZEBO (仿真)
- GPS/RTK
- UWB (超宽带)
- VINS (视觉惯性SLAM)
- MID360 (激光雷达)
- BSA_SLAM

### 3. 任务规划系统

**主要组件**:
- `mission_planner`: 任务规划器
- `mission_waypoint_node`: 航点控制器
- `mission_waypoint.h`: 航点控制算法

**功能特性**:
- 自动航点导航
- 任务状态管理
- 路径规划
- 任务中断和恢复

### 4. 通信系统

**MQTT通信**:
- 远程命令控制
- 状态数据回传
- 实时参数配置
- 多设备桥接

**支持的通信协议**:
- MQTT (主要)
- ROS话题
- 串口通信

### 5. 视觉定位系统

**ArUco码识别**:
- 精确定位
- 自动降落
- 多码识别
- 位姿估计

## 配置文件说明

### 主配置文件 (uav_control.yaml)

```yaml
control:
  pos_controller: 0                    # 位置控制器类型
  enable_external_control: false       # 是否启用外部控制
  Takeoff_height: 3.0                  # 起飞高度
  Land_speed: 0.2                      # 降落速度
  Rtl_height: 3.0                      # 返航高度
  disable_offboard_when_mission: true  # 任务模式时禁用OFFBOARD
  Disarm_height: 0.1                   # 上锁高度
  location_source: 4                   # 定位源
  maximum_safe_vel_xy: 1.0             # 最大安全水平速度
  maximum_safe_vel_z: 1.0              # 最大安全垂直速度
  maximum_vel_error_for_vision: 2.0    # 最大视觉速度误差

geo_fence:                             # 地理围栏
  x_min: -100.0
  x_max: 100.0
  y_min: -100.0
  y_max: 100.0
  z_min: -100.0
  z_max: 50.0
```

### MQTT命令格式 (mqtt_command.json)

**基本控制命令**:
```json
{
  "command": {
    "Takeoff": {"takeoff_height": 3.0},    // 一键起飞
    "Land": {"land_vel": 0.6},             // 一键降落
    "RTL": {"rtl_height": 30.0},           // 一键返航
    "Hover": 0,                            // 悬停
    "Mission": 0                           // 自主巡航
  }
}
```

**速度控制**:
```json
{
  "command": {
    "Velocity": [0.5, 0.0, 0.0, 0.0]      // [vx, vy, vz, yaw]
  }
}
```

**位置控制**:
```json
{
  "command": {
    "Position": [
      [1.0, 0.0, 0.0, 0.0],               // [x, y, z, yaw]
      [0.0, 2.0, 0.0, 0.0]
    ]
  }
}
```

**任务规划**:
```json
{
  "command": {
    "Mission": 1,
    "BeginPoint": {"takeoff_height": 3.0},
    "Waypoints": [
      {
        "command": 16,
        "x": 29.591691970825195,
        "y": 106.56697845458984,
        "z": 10.0,
        "param1": 3.0
      }
    ],
    "EndPoint": {
      "command": 22,
      "param1": 15.0
    }
  }
}
```

## 启动文件说明

### 1. PX4飞控连接 (px4.launch)

```xml
<launch>
  <arg name="fcu_url" default="/dev/ttyUSB0:921600" />
  <arg name="tgt_system" default="1" />
  
  <group ns="/uav1">
    <include file="$(find mavros)/launch/node.launch">
      <arg name="fcu_url" value="$(arg fcu_url)" />
      <arg name="tgt_system" value="$(arg tgt_system)" />
    </include>
  </group>
</launch>
```

### 2. 室外控制 (uav_outdor_control.launch)

```xml
<launch>
  <arg name="uav_id" default="1" />
  
  <!-- 状态估计器 -->
  <include file="$(find uavcontrol)/launch/uav_estimator.launch">
    <arg name="uav_id" value="$(arg uav_id)" />
  </include>
  
  <!-- 主控制器 -->
  <node pkg="uavcontrol" type="uav_control_main" name="uav_control_main" output="screen">
    <param name="uav_id" value="$(arg uav_id)" />
  </node>
</launch>
```

### 3. 任务规划 (mission_planning.launch)

```xml
<launch>
  <arg name="uav_id" default="1" />
  
  <!-- 任务规划器 -->
  <node pkg="uavcontrol" type="mission_planner" name="mission_planner" output="screen">
    <param name="uav_id" value="$(arg uav_id)" />
  </node>
  
  <!-- 航点控制器 -->
  <node pkg="uavcontrol" type="mission_waypoint_node" name="mission_controller" output="screen">
    <param name="uav_id" value="$(arg uav_id)" />
  </node>
</launch>
```

## 使用方法

### 1. 基本启动流程

```bash
# 1. 启动PX4飞控连接
roslaunch uavcontrol px4.launch

# 2. 启动状态估计器
roslaunch uavcontrol uav_estimator.launch

# 3. 启动主控制器
roslaunch uavcontrol uav_outdor_control.launch

# 4. 启动命令发布器
roslaunch uavcontrol uav_command_pub.launch
```

### 2. 使用脚本启动

```bash
# 启动完整控制系统
./sh/mission_planning_with_controller.sh

# 启动室外控制
./sh/uav_outdor_control.sh

# 启动室内控制
./sh/uav_indor_control.sh
```

### 3. 手动控制

```bash
# 发布速度控制命令
rostopic pub /uav1/uav_command uavcontrol_msgs/UAVCommand "velocity: [0.5, 0.0, 0.0, 0.0]"

# 发布位置控制命令
rostopic pub /uav1/uav_command uavcontrol_msgs/UAVCommand "position: [1.0, 0.0, 3.0, 0.0]"
```

### 4. MQTT控制

通过MQTT发送JSON命令：

```bash
# 起飞命令
mosquitto_pub -h localhost -t "uav/command" -m '{"command": {"Takeoff": {"takeoff_height": 3.0}}}'

# 速度控制
mosquitto_pub -h localhost -t "uav/command" -m '{"command": {"Velocity": [0.5, 0.0, 0.0, 0.0]}}'
```

## 开发指南

### 1. 添加新的位置控制器

1. 在 `include/Position_Controller/` 创建新的控制器头文件
2. 在 `uav_controller.h` 中添加控制器枚举
3. 在 `uav_controller.cpp` 中实现控制器逻辑
4. 更新配置文件中的控制器选择

### 2. 添加新的传感器支持

1. 在 `uav_estimator.h` 中添加传感器订阅
2. 在 `uav_estimator.cpp` 中实现数据处理
3. 更新定位源枚举和切换逻辑
4. 配置传感器外参

### 3. 自定义消息类型

1. 在 `uavcontrol_msgs` 包中定义新消息
2. 更新 `package.xml` 和 `CMakeLists.txt`
3. 在代码中使用新消息类型

### 4. 扩展MQTT功能

1. 在 `usr_mqtt.hpp` 中添加新的命令处理
2. 更新 `uav_command_pub.cpp` 中的命令解析
3. 添加相应的控制逻辑

## 故障排除

### 常见问题

1. **飞控连接失败**
   - 检查串口权限: `sudo chmod 666 /dev/ttyUSB0`
   - 确认波特率设置
   - 检查MAVLink协议版本

2. **定位源切换失败**
   - 检查传感器数据是否正常
   - 确认传感器外参配置
   - 查看状态估计器日志

3. **控制指令无响应**
   - 检查飞控模式是否为OFFBOARD
   - 确认遥控器开关设置
   - 验证地理围栏配置

4. **MQTT通信失败**
   - 检查MQTT服务器连接
   - 确认主题名称正确
   - 验证JSON格式

### 调试技巧

```bash
# 查看节点状态
rosnode list
rosnode info /uav_control_main

# 查看话题数据
rostopic echo /uav1/uav_state
rostopic echo /uav1/uav_command

# 查看参数
rosparam get /uav1/uav_control_main

# 查看日志
rosrun rqt_console rqt_console
```

## 性能优化

### 1. 实时性优化

- 使用高优先级线程
- 优化算法计算效率
- 减少不必要的内存分配

### 2. 稳定性优化

- 添加数据有效性检查
- 实现故障恢复机制
- 优化传感器融合算法

### 3. 通信优化

- 使用消息压缩
- 实现断线重连
- 优化数据传输频率

## 许可证

本项目采用 MIT 许可证。

## 维护者

- Yuhua Qi (qiyh8@mail.sysu.edu.cn)

## 更新日志

### V3.0
- 集成FAST-LIO SLAM系统
- 添加MQTT通信支持
- 完善任务规划功能
- 优化ArUco定位系统

### V2.0
- 基础飞行控制功能
- PX4飞控集成
- 传感器数据融合

### V1.0
- 初始版本发布
- 基本控制框架 
