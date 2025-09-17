# EKF2重置功能使用说明

## 概述

本功能提供了通过串口模拟发送mavlink协议消息至PX4飞控的能力，可以模拟QGC中mavlink console的`ekf2 stop`和`ekf2 start`命令来重置EKF2。

## 功能特点

- **独立节点**: 不依赖于`uav_controller.cpp`，完全独立运行
- **多种使用方式**: 支持命令行、ROS服务、Launch文件三种使用方式
- **安全性**: 包含等待时间和错误处理机制
- **灵活性**: 支持单独执行stop/start或完整重置流程

## 文件结构

```
├── utils/ekf2_reset_node.cpp          # 主要功能实现文件
├── launch/ekf2_reset.launch           # Launch启动文件
├── scripts/ekf2_reset.sh              # 便利脚本
└── EKF2_RESET_README.md               # 本说明文档
```

## 编译要求

确保已经在`CMakeLists.txt`中添加了以下内容：

```cmake
# EKF2 Reset Node
add_executable(ekf2_reset_node utils/ekf2_reset_node.cpp)
add_dependencies(ekf2_reset_node ${catkin_EXPORTED_TARGETS})
target_link_libraries(ekf2_reset_node ${catkin_LIBRARIES})
```

## 编译方法

```bash
cd /path/to/autouav_platform
catkin_make
# 或者
catkin build uavcontrol
```

## 使用方法

### 前提条件

1. 确保PX4飞控已连接并启动mavros：
```bash
roslaunch uavcontrol px4.launch
```

2. 检查mavros连接状态：
```bash
rostopic list | grep mavros
```

### 方法1：命令行直接使用

#### 完整EKF2重置（推荐）
```bash
rosrun uavcontrol ekf2_reset_node _uav_id:=2 reset
```

#### 仅发送stop命令
```bash
rosrun uavcontrol ekf2_reset_node _uav_id:=2 stop
```

#### 仅发送start命令
```bash
rosrun uavcontrol ekf2_reset_node _uav_id:=2 start
```

### 方法2：ROS服务调用

#### 启动服务节点
```bash
rosrun uavcontrol ekf2_reset_node _uav_id:=2
```

#### 调用服务
```bash
rosservice call /uav2/ekf2_reset
```

### 方法3：Launch文件启动

#### 使用默认参数（UAV2，完整重置）
```bash
roslaunch uavcontrol ekf2_reset.launch
```

#### 自定义参数
```bash
roslaunch uavcontrol ekf2_reset.launch uav_id:=1 command:=reset
```

### 方法4：便利脚本

#### 使用脚本进行完整重置
```bash
./src/uavcontrol/scripts/ekf2_reset.sh 2 reset
```

#### 查看帮助
```bash
./src/uavcontrol/scripts/ekf2_reset.sh --help
```

## 参数说明

### 节点参数

- `uav_id`: 无人机ID，默认为2
- 支持的命令: `reset`, `stop`, `start`

### Launch文件参数

- `uav_id`: 无人机ID (默认: 2)
- `command`: EKF2操作命令 (默认: reset)
- `show_usage`: 是否显示使用说明 (默认: false)

## 工作原理

1. **串口控制**: 通过mavlink的`SERIAL_CONTROL`消息模拟QGC控制台
2. **命令发送**: 发送`ekf2 stop`和`ekf2 start`命令至PX4 shell
3. **时序控制**: 在stop和start之间等待3秒，确保EKF2完全停止后再重启

## 消息流程

```
ROS Node -> mavlink_message_t -> mavros_msgs::Mavlink -> /mavlink/to -> PX4 Autopilot
```

## 安全注意事项

⚠️ **重要提醒**：

1. **定位影响**: EKF2重置会暂时中断位置估计
2. **飞行状态**: 建议在地面或悬停状态下使用
3. **备用定位**: 确保有其他定位源可用（GPS、光流等）
4. **测试环境**: 首次使用请在安全的测试环境中进行

## 故障排除

### 常见问题

1. **mavros连接问题**
   - 检查`rostopic list | grep mavros`
   - 确认px4.launch已正确启动

2. **权限问题**
   - 确保串口权限正确
   - 检查用户是否在dialout组中

3. **编译错误**
   - 确保message_convert.hpp路径正确
   - 检查依赖包是否安装完整

4. **命令无响应**
   - 检查PX4控制台是否可用
   - 确认mavlink通信正常

### 调试方法

#### 查看mavlink消息
```bash
rostopic echo /uav2/mavlink/to
```

#### 检查节点状态
```bash
rosnode list | grep ekf2
rosnode info /ekf2_reset_node
```

#### 查看服务列表
```bash
rosservice list | grep ekf2
```

## 扩展功能

### 添加其他PX4命令

可以在`ekf2_reset_node.cpp`中添加其他PX4 shell命令：

```cpp
void sendCustomCommand(const std::string& cmd)
{
    sendSerialControl(cmd);
}
```

### 集成到其他系统

可以通过ROS服务接口轻松集成到其他控制系统中：

```cpp
// C++调用示例
ros::ServiceClient client = nh.serviceClient<std_srvs::Empty>("/uav2/ekf2_reset");
std_srvs::Empty srv;
client.call(srv);
```

```python
# Python调用示例
import rospy
from std_srvs.srv import Empty

rospy.wait_for_service('/uav2/ekf2_reset')
reset_service = rospy.ServiceProxy('/uav2/ekf2_reset', Empty)
reset_service()
```

## 版本信息

- **创建日期**: 2025-09-11
- **适用系统**: PX4 + MAVROS
- **ROS版本**: Melodic/Noetic
- **测试平台**: Ubuntu 18.04/20.04

## 技术支持

如有问题，请检查：
1. ROS环境是否正确配置
2. MAVROS版本兼容性
3. PX4固件版本兼容性
4. 系统权限设置

---

**注意**: 本功能仅用于EKF2重置，请勿在飞行过程中不当使用。
