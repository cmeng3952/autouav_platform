# 基础接口模块 - Basic Interface Scripts

[![Shell](https://img.shields.io/badge/Shell-Bash-green)](https://www.gnu.org/software/bash/)
[![UAV SDK](https://img.shields.io/badge/UAV%20SDK-v3.0-blue)](https://github.com)

## 📋 模块概述

基础接口模块提供UAV SDK系统的基础启动脚本，包含标准的无人机控制系统启动流程和ArUco降落系统启动流程。这些脚本简化了系统启动过程，提供一键式的系统初始化功能。

### 🌟 主要功能

- **🚀 一键系统启动**: 自动启动完整的UAV控制系统
- **📱 多终端管理**: 在独立终端中启动各个功能模块
- **⏱️ 启动顺序控制**: 合理的启动延迟确保系统稳定初始化
- **🎯 专用场景支持**: 专门的ArUco降落系统启动配置

## 📦 脚本清单

### 1. uav_basic_interface.sh - 基础系统接口
**功能**: 启动完整的UAV基础控制系统
**文件大小**: 442B (12行)
**启动组件**:
- PX4飞控连接
- UAV主控制器  
- UAV命令发布器
- ArUco视觉检测
- MQTT通信桥接

### 2. uav_command_pub_aruco_land.sh - ArUco降落系统
**功能**: 启动专用于ArUco精确降落的完整系统
**文件大小**: 488B (9行)  
**启动组件**:
- ROS核心 (roscore)
- UAV主控制器
- PX4飞控连接
- UAV命令发布器
- ArUco视觉检测
- MQTT通信桥接

## 🚀 使用指南

### 脚本1: uav_basic_interface.sh

#### 功能描述
启动UAV SDK的基础控制系统，适用于一般的飞行控制和测试场景。

#### 启动流程
```bash
#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uav_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol mqtt_bridge.launch; exec bash"'
```

#### 使用方法
```bash
# 进入基础接口目录
cd ~/uav_ws/src/UAV_SDK/基础接口

# 赋予执行权限
chmod +x uav_basic_interface.sh

# 启动基础系统
./uav_basic_interface.sh
```

#### 启动时序
1. **0秒**: PX4飞控连接启动
2. **2秒**: UAV主控制器启动
3. **4秒**: UAV命令发布器启动  
4. **6秒**: ArUco视觉检测启动
5. **8秒**: MQTT通信桥接启动

### 脚本2: uav_command_pub_aruco_land.sh

#### 功能描述
启动专门用于ArUco精确降落的完整系统，包含ROS核心的启动。

#### 启动流程
```bash
#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol px4.launch; exec bash"'\
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol mqtt_bridge.launch; exec bash"'
```

#### 使用方法
```bash
# 进入基础接口目录
cd ~/uav_ws/src/UAV_SDK/基础接口

# 赋予执行权限
chmod +x uav_command_pub_aruco_land.sh

# 启动ArUco降落系统
./uav_command_pub_aruco_land.sh
```

#### 启动时序
1. **0秒**: ROS核心 (roscore) 启动
2. **3秒**: UAV主控制器启动
3. **6秒**: PX4飞控连接启动
4. **9秒**: UAV命令发布器启动
5. **12秒**: ArUco视觉检测启动
6. **15秒**: MQTT通信桥接启动

## 🔧 系统要求

### 软件依赖
- Ubuntu 18.04/20.04
- ROS Melodic/Noetic
- GNOME Terminal
- UAV SDK完整安装

### 硬件要求
- PX4兼容飞控
- USB相机 (ArUco检测)
- 串口连接设备

## 🧪 测试流程

### 基础功能测试

#### 测试1: 脚本权限检查
```bash
# 检查脚本是否可执行
ls -l ~/uav_ws/src/UAV_SDK/基础接口/*.sh

# 预期结果: 所有.sh文件具有执行权限 (x)
```

#### 测试2: 依赖检查
```bash
# 检查gnome-terminal
which gnome-terminal
# 预期结果: /usr/bin/gnome-terminal

# 检查ROS环境
echo $ROS_DISTRO
source ~/uav_ws/devel/setup.bash
# 预期结果: melodic 或 noetic

# 检查launch文件存在性
ls ~/uav_ws/src/UAV_SDK/src/uavcontrol/launch/px4.launch
ls ~/uav_ws/src/UAV_SDK/src/uavcontrol/launch/uav_control.launch
# 预期结果: 文件存在
```

### 启动测试流程

#### 测试3: uav_basic_interface.sh 启动测试
```bash
#!/bin/bash
# 测试脚本: test_basic_interface.sh

echo "开始测试 uav_basic_interface.sh..."

# 1. 启动脚本
cd ~/uav_ws/src/UAV_SDK/基础接口
./uav_basic_interface.sh &
SCRIPT_PID=$!

# 2. 等待系统启动
echo "等待系统启动..."
sleep 15

# 3. 检查节点状态
echo "检查ROS节点状态..."
rosnode list | grep -E "(px4|uav_control|command_pub|aruco|mqtt)"

# 4. 检查话题发布
echo "检查话题发布状态..."
timeout 5 rostopic list | grep -E "(mavros|uav1|aruco|mqtt)"

# 5. 检查数据流
echo "检查数据流..."
timeout 3 rostopic echo /mavros/state | head -3
timeout 3 rostopic echo /uav1/uav_state | head -3

echo "基础接口测试完成"
```

#### 测试4: ArUco降落系统测试
```bash
#!/bin/bash
# 测试脚本: test_aruco_land_interface.sh

echo "开始测试 uav_command_pub_aruco_land.sh..."

# 1. 确保没有其他roscore运行
pkill -f roscore
sleep 2

# 2. 启动ArUco降落系统
cd ~/uav_ws/src/UAV_SDK/基础接口
./uav_command_pub_aruco_land.sh &
SCRIPT_PID=$!

# 3. 等待系统完全启动
echo "等待ArUco降落系统启动..."
sleep 20

# 4. 检查roscore状态
echo "检查roscore状态..."
rostopic list > /dev/null && echo "✅ roscore正常" || echo "❌ roscore异常"

# 5. 检查ArUco检测
echo "检查ArUco检测功能..."
timeout 5 rostopic echo /aruco_detection/pose | head -5

# 6. 测试降落触发
echo "测试ArUco降落触发..."
rostopic pub -1 /uav1/aruco_trigger_signal std_msgs/Bool "data: true"

echo "ArUco降落系统测试完成"
```

### 性能测试

#### 测试5: 启动时间测试
```bash
#!/bin/bash
# 启动时间测试脚本

echo "测试系统启动时间..."

# 记录开始时间
START_TIME=$(date +%s)

# 启动基础系统
./uav_basic_interface.sh &

# 等待所有节点启动
while [ $(rosnode list 2>/dev/null | wc -l) -lt 5 ]; do
    sleep 1
done

# 记录结束时间
END_TIME=$(date +%s)
STARTUP_TIME=$((END_TIME - START_TIME))

echo "系统启动时间: ${STARTUP_TIME}秒"
echo "目标启动时间: <30秒"

if [ $STARTUP_TIME -lt 30 ]; then
    echo "✅ 启动时间测试通过"
else
    echo "❌ 启动时间测试失败"
fi
```

#### 测试6: 内存使用测试
```bash
#!/bin/bash
# 内存使用测试

echo "测试系统内存使用..."

# 启动前内存使用
MEM_BEFORE=$(free -m | awk 'NR==2{printf "%.1f", $3*100/$2}')

# 启动系统
./uav_basic_interface.sh &
sleep 20

# 启动后内存使用
MEM_AFTER=$(free -m | awk 'NR==2{printf "%.1f", $3*100/$2}')

# 计算内存增长
MEM_INCREASE=$(echo "$MEM_AFTER - $MEM_BEFORE" | bc)

echo "启动前内存使用: ${MEM_BEFORE}%"
echo "启动后内存使用: ${MEM_AFTER}%"
echo "内存增长: ${MEM_INCREASE}%"

# 检查ROS节点内存使用
echo "ROS节点内存使用:"
ps aux | grep ros | awk '{sum+=$6} END {printf "总计: %.1f MB\n", sum/1024}'
```

## 🐛 故障排除

### 常见问题

#### 问题1: 终端无法启动
**症状**: gnome-terminal命令失败
```bash
# 检查终端程序
which gnome-terminal
sudo apt install gnome-terminal

# 或使用其他终端
sudo apt install xterm
# 修改脚本使用 xterm
```

#### 问题2: launch文件未找到
**症状**: "No such file or directory" 错误
```bash
# 检查文件路径
find ~/uav_ws -name "px4.launch"
find ~/uav_ws -name "uav_control.launch"

# 检查环境变量
echo $ROS_PACKAGE_PATH
source ~/uav_ws/devel/setup.bash
```

#### 问题3: 节点启动失败
**症状**: 某些ROS节点无法启动
```bash
# 检查单个launch文件
roslaunch uavcontrol px4.launch

# 查看错误日志
roscd uavcontrol
cat ~/.ros/log/latest/px4-*.log
```

#### 问题4: ArUco检测无响应
**症状**: ArUco检测节点无数据输出
```bash
# 检查相机设备
ls /dev/video*

# 检查相机权限
sudo chmod 666 /dev/video0

# 测试相机
rosrun usb_cam usb_cam_node
rostopic echo /usb_cam/image_raw
```

### 应急停止流程

```bash
#!/bin/bash
# 应急停止脚本 emergency_stop.sh

echo "执行应急停止..."

# 1. 停止所有ROS节点
rosnode kill -a

# 2. 杀死相关进程
pkill -f "roslaunch uavcontrol"
pkill -f "roslaunch spirecv_ros"
pkill -f roscore

# 3. 关闭所有gnome-terminal窗口
pkill gnome-terminal

echo "系统已停止"
```

## 📊 性能指标

### 启动性能
- **预期启动时间**: <30秒
- **内存使用增长**: <500MB
- **CPU使用率峰值**: <50%

### 稳定性指标
- **节点存活率**: >95%
- **数据丢包率**: <1%
- **系统响应延迟**: <100ms

## 🔄 维护建议

### 定期检查
```bash
# 每周执行系统检查
cd ~/uav_ws/src/UAV_SDK/基础接口

# 1. 检查脚本完整性
md5sum *.sh > script_checksums.txt

# 2. 检查依赖包
rosdep check --from-paths ~/uav_ws/src --ignore-src

# 3. 清理日志文件
find ~/.ros/log -name "*.log" -mtime +7 -delete
```

### 脚本更新
当系统配置发生变化时，及时更新启动脚本：

1. **添加新模块**: 在脚本中增加对应的launch命令
2. **修改启动顺序**: 调整sleep延迟时间
3. **更新路径**: 修改launch文件路径
4. **测试验证**: 运行完整测试流程

## 📚 扩展开发

### 自定义启动脚本

```bash
#!/bin/bash
# 自定义启动脚本模板

# 设置变量
UAV_ID=${1:-1}
CONFIG_PATH=${2:-"default"}

# 启动终端
gnome-terminal \
--window -e "bash -c 'roscore; exec bash'" \
--tab -e "bash -c 'sleep 3; roslaunch uavcontrol px4.launch uav_id:=$UAV_ID; exec bash'" \
--tab -e "bash -c 'sleep 5; roslaunch uavcontrol uav_control.launch config:=$CONFIG_PATH; exec bash'"

echo "自定义系统启动完成"
```

### 批量启动多机
```bash
#!/bin/bash
# 多机启动脚本

for i in {1..3}; do
    echo "启动UAV $i..."
    gnome-terminal --window -e "bash -c 'export UAV_ID=$i; ./uav_basic_interface.sh; exec bash'"
    sleep 10
done
```

## 📜 许可证

本模块遵循 MIT 许可证

## 👥 维护者

- **负责人**: UAV控制实验室
- **模块**: 基础接口启动脚本

---

💡 **提示**: 在使用脚本前，请确保已完成UAV SDK的完整编译和环境配置。 