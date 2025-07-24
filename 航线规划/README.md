# 航线规划模块 - Mission Planning Scripts

[![UAV SDK](https://img.shields.io/badge/UAV%20SDK-v3.0-blue)](https://github.com)
[![Mission](https://img.shields.io/badge/Mission-Planning-orange)](https://github.com)

## 📋 模块概述

航线规划模块提供专业的无人机任务规划和执行功能，包含室外GPS控制、自主任务规划和ArUco精确降落三大核心场景。该模块支持复杂的航点任务、实时SLAM建图和高精度视觉定位，适用于测绘、巡检、搜救等多种应用场景。

### 🌟 核心功能

- **🗺️ 航点任务规划**: 支持复杂的3D航点任务和路径规划
- **🌐 室外GPS导航**: 基于GPS的大范围室外飞行控制
- **🎯 精确视觉降落**: ArUco码引导的厘米级精确降落
- **📡 远程任务管理**: MQTT远程任务下发和状态监控
- **🔄 任务状态机**: 完整的任务执行状态管理和异常处理

## 📦 脚本清单

### 1. uav_outdor_control.sh - 室外控制系统
**功能**: 启动GPS/RTK导航的室外飞行控制系统
**文件大小**: 538B (11行)
**适用场景**: 大范围室外飞行、测绘作业、长距离巡检

### 2. mission_planning.sh - 任务规划系统  
**功能**: 启动完整的航点任务规划和执行系统
**文件大小**: 534B (11行)
**适用场景**: 自主航点任务、路径规划、自动化作业

### 3. aruco_land.sh - ArUco降落系统
**功能**: 启动专门的ArUco视觉精确降落系统
**文件大小**: 354B (9行)
**适用场景**: 精确定点降落、移动平台降落、救援投送

## 🚀 使用指南

### 脚本1: uav_outdor_control.sh - 室外控制系统

#### 功能描述
启动基于GPS/RTK的室外飞行控制系统，支持大范围飞行和高精度定位。

#### 启动流程
```bash
#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol uav_outdor_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"'
```

#### 系统架构
```
室外控制系统
├── GPS/RTK定位源
├── 状态估计与融合
├── 飞行控制器
├── ArUco备用降落
├── MQTT状态上传
└── 应急处理机制
```

#### 使用方法
```bash
# 进入航线规划目录
cd ~/uav_ws/src/UAV_SDK/航线规划

# 启动室外控制系统
./uav_outdor_control.sh

# 系统启动顺序:
# 0s:  室外控制启动器
# 2s:  PX4飞控连接
# 4s:  命令发布器
# 7s:  ArUco检测 (备用)
# 12s: MQTT状态桥接
# 18s: ArUco降落控制
```

#### 典型使用场景
```bash
# 场景1: GPS航点任务
mosquitto_pub -h localhost -t "uavcontrol/command/uav1" -m '{
  "command": {
    "Mission": 1,
    "Waypoints": [
      {"frame": 0, "command": 22, "x": 22.5726, "y": 113.9364, "z": 50.0},
      {"frame": 0, "command": 16, "x": 22.5730, "y": 113.9370, "z": 50.0},
      {"frame": 0, "command": 21, "x": 22.5726, "y": 113.9364, "z": 0.0}
    ]
  }
}'

# 场景2: RTL返航
rostopic pub -1 /uav1/uav_command uavcontrol_msgs/UAVCommand \
  "command: 'RTL', rtl_height: 50.0"
```

### 脚本2: mission_planning.sh - 任务规划系统

#### 功能描述
启动完整的航点任务规划和执行系统，支持复杂的3D航点任务和实时状态监控。

#### 启动流程
```bash
#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 1; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol mission_planning.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"'
```

#### 系统架构
```
任务规划系统
├── 飞控通信层
├── 状态估计器
├── 任务规划器
│   ├── 航点解析
│   ├── 路径规划
│   └── 执行监控
├── MQTT通信
├── 视觉定位
└── 精确降落
```

#### 任务规划器功能
- **航点任务解析**: 支持MAVLink标准航点格式
- **路径优化**: 自动生成平滑飞行轨迹
- **任务监控**: 实时监控任务执行状态
- **异常处理**: 自动处理任务中断和恢复
- **安全机制**: 地理围栏和高度限制

#### 支持的任务类型
```json
{
  "mission_types": {
    "waypoint_navigation": "标准航点导航",
    "area_scan": "区域扫描任务", 
    "point_inspection": "定点巡检任务",
    "search_pattern": "搜索模式飞行",
    "emergency_landing": "应急降落程序"
  }
}
```

#### 使用示例
```bash
# 启动任务规划系统
./mission_planning.sh

# 发送复杂任务
cat > complex_mission.json << EOF
{
  "command": {
    "Mission": 1,
    "Waypoints": [
      {"frame": 1, "command": 84, "x": 0, "y": 0, "z": -5, "param1": 0},
      {"frame": 1, "command": 16, "x": 20, "y": 0, "z": -10, "param1": 8},
      {"frame": 1, "command": 16, "x": 20, "y": 20, "z": -15, "param1": 5},
      {"frame": 1, "command": 16, "x": 0, "y": 20, "z": -10, "param1": 8},
      {"frame": 1, "command": 16, "x": 0, "y": 0, "z": -5, "param1": 3},
      {"frame": 1, "command": 21, "x": 0, "y": 0, "z": 0, "param1": 0}
    ]
  }
}
EOF

mosquitto_pub -h localhost -t "uavcontrol/command/uav1" -f complex_mission.json
```

### 脚本3: aruco_land.sh - ArUco降落系统

#### 功能描述
启动专门的ArUco视觉精确降落系统，实现厘米级精度的定点降落。

#### 启动流程
```bash
#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 1; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"'
```

#### 精确降落流程
```
ArUco降落系统
├── 相机图像获取
├── ArUco码检测
│   ├── 码字典匹配
│   ├── 位姿估计
│   └── 精度验证
├── 降落控制器
│   ├── 水平位置校正
│   ├── 垂直下降控制
│   └── 着陆检测
└── 安全保护机制
```

#### ArUco码配置
```yaml
# ArUco检测参数
aruco_config:
  dictionary: "DICT_6X6_250"      # 码字典类型
  marker_sizes:                   # 标记尺寸 (m)
    1: 0.20    # 主降落标记 20cm
    2: 0.15    # 备用标记 15cm  
    3: 0.10    # 精确标记 10cm
  detection_params:
    adaptiveThreshWinSizeMin: 3
    adaptiveThreshWinSizeMax: 23
    minMarkerPerimeterRate: 0.03
    maxMarkerPerimeterRate: 4.0
```

#### 降落精度指标
- **水平精度**: ±5cm (距离3m时)
- **检测距离**: 0.5m - 10m
- **检测频率**: ≥15Hz
- **降落速度**: 0.2-0.5 m/s

## 🧪 测试流程和SOP

### 测试准备

#### 环境准备检查清单
```bash
# 1. 硬件检查
□ GPS/RTK接收机工作正常
□ 相机图像清晰，焦距合适
□ ArUco标记打印质量良好
□ 飞控与地面站通信正常
□ 电池电量充足 (>80%)

# 2. 软件检查  
□ UAV SDK编译成功
□ 所有launch文件存在
□ MQTT服务器正常运行
□ ROS环境配置正确

# 3. 安全检查
□ 测试场地空旷安全
□ 天气条件适宜 (风速<5m/s)
□ 应急操作员就位
□ 紧急降落区域准备
```

### 单元测试

#### 测试1: 室外控制系统启动测试
```bash
#!/bin/bash
# 测试文件: test_outdoor_control.sh

echo "=== 室外控制系统启动测试 ==="

# 1. 启动系统
cd ~/uav_ws/src/UAV_SDK/航线规划
./uav_outdor_control.sh &
sleep 20

# 2. 检查关键节点
echo "检查ROS节点..."
REQUIRED_NODES="px4 uav_estimator command_pub aruco_detection mqtt_bridge aruco_land"
for node in $REQUIRED_NODES; do
    if rosnode list | grep -q $node; then
        echo "✅ $node 节点正常"
    else
        echo "❌ $node 节点异常"
    fi
done

# 3. 检查GPS状态
echo "检查GPS状态..."
timeout 10 rostopic echo /mavros/global_position/global | head -5
GPS_STATUS=$?
if [ $GPS_STATUS -eq 0 ]; then
    echo "✅ GPS数据正常"
else
    echo "❌ GPS数据异常"
fi

# 4. 检查MQTT连接
echo "检查MQTT连接..."
mosquitto_pub -h localhost -t "test/outdoor" -m "ping"
echo "✅ MQTT连接测试完成"

echo "=== 室外控制系统测试完成 ==="
```

#### 测试2: 任务规划系统功能测试
```bash
#!/bin/bash
# 测试文件: test_mission_planning.sh

echo "=== 任务规划系统功能测试 ==="

# 1. 启动任务规划系统
./mission_planning.sh &
sleep 25

# 2. 测试简单航点任务
echo "测试简单航点任务..."
cat > test_simple_mission.json << EOF
{
  "command": {
    "Mission": 1,
    "Waypoints": [
      {"frame": 1, "command": 22, "x": 0, "y": 0, "z": -3},
      {"frame": 1, "command": 16, "x": 5, "y": 0, "z": -3, "param1": 5},
      {"frame": 1, "command": 21, "x": 0, "y": 0, "z": 0}
    ]
  }
}
EOF

mosquitto_pub -h localhost -t "uavcontrol/command/uav1" -f test_simple_mission.json
sleep 5

# 3. 检查任务接收
echo "检查任务接收状态..."
if grep -q "Mission received" ~/.ros/log/latest/*.log; then
    echo "✅ 任务接收正常"
else
    echo "❌ 任务接收异常"
fi

# 4. 测试任务状态查询
echo "查询任务状态..."
timeout 5 rostopic echo /uav1/mission_status | head -3

# 5. 测试任务取消
echo "测试任务取消..."
mosquitto_pub -h localhost -t "uavcontrol/command/uav1" \
  -m '{"command": {"Mission": 0}}'

echo "=== 任务规划系统测试完成 ==="
```

#### 测试3: ArUco降落系统精度测试
```bash
#!/bin/bash
# 测试文件: test_aruco_landing.sh

echo "=== ArUco降落系统精度测试 ==="

# 1. 启动ArUco降落系统
./aruco_land.sh &
sleep 15

# 2. 检查相机图像
echo "检查相机图像..."
timeout 3 rostopic echo /usb_cam/image_raw | head -5
if [ $? -eq 0 ]; then
    echo "✅ 相机图像正常"
else
    echo "❌ 相机图像异常"
fi

# 3. ArUco检测测试
echo "ArUco检测测试 (请将ArUco标记放入相机视野)..."
read -p "按Enter继续检测测试..."

# 记录检测数据
timeout 30 rostopic echo /aruco_detection/pose > aruco_detection.log &

echo "检测进行中，请移动ArUco标记测试检测稳定性..."
sleep 30

# 4. 分析检测精度
echo "分析检测精度..."
python3 << EOF
import re

with open('aruco_detection.log', 'r') as f:
    data = f.read()
    
# 简单统计检测次数
pose_count = len(re.findall(r'position:', data))
print(f"检测帧数: {pose_count}")

if pose_count > 10:
    print("✅ ArUco检测稳定")
else:
    print("❌ ArUco检测不稳定")
EOF

# 5. 测试降落触发
echo "测试降落触发..."
rostopic pub -1 /uav1/aruco_trigger_signal std_msgs/Bool "data: true"

# 检查降落逻辑
if grep -q "ArUco landing triggered" ~/.ros/log/latest/*.log; then
    echo "✅ 降落触发正常"
else
    echo "❌ 降落触发异常"
fi

echo "=== ArUco降落系统测试完成 ==="
```

### 集成测试

#### 测试4: 完整飞行任务测试
```bash
#!/bin/bash
# 测试文件: test_complete_mission.sh

echo "=== 完整飞行任务集成测试 ==="

# 安全确认
echo "⚠️  安全确认："
echo "1. 确认测试场地安全"
echo "2. 确认无人机状态良好"
echo "3. 确认应急操作员就位"
read -p "确认安全条件后按Enter继续..."

# 1. 启动任务规划系统
echo "启动任务规划系统..."
./mission_planning.sh &
sleep 30

# 2. 检查系统状态
echo "检查飞控状态..."
rostopic echo /mavros/state | head -3

# 3. GPS信号检查
echo "检查GPS信号..."
GPS_SATS=$(rostopic echo /mavros/global_position/global -n 1 | grep satellites_visible | awk '{print $2}')
echo "GPS卫星数: $GPS_SATS"

if [ "$GPS_SATS" -ge 8 ]; then
    echo "✅ GPS信号良好"
else
    echo "❌ GPS信号不足，建议移至空旷区域"
    exit 1
fi

# 4. 发送完整任务
echo "发送完整飞行任务..."
cat > complete_mission.json << EOF
{
  "command": {
    "Mission": 1,
    "Waypoints": [
      {"frame": 1, "command": 84, "x": 0, "y": 0, "z": -5, "param1": 0},
      {"frame": 1, "command": 16, "x": 10, "y": 0, "z": -5, "param1": 10},
      {"frame": 1, "command": 16, "x": 10, "y": 10, "z": -8, "param1": 10},
      {"frame": 1, "command": 16, "x": 0, "y": 10, "z": -8, "param1": 10},
      {"frame": 1, "command": 16, "x": 0, "y": 0, "z": -5, "param1": 5},
      {"frame": 1, "command": 21, "x": 0, "y": 0, "z": 0, "param1": 0}
    ]
  }
}
EOF

mosquitto_pub -h localhost -t "uavcontrol/command/uav1" -f complete_mission.json

# 5. 任务监控
echo "任务执行监控..."
echo "任务包含: 起飞->航点1->航点2->航点3->返回->降落"
echo "预计执行时间: 2-3分钟"

# 监控任务状态
timeout 300 rostopic echo /uav1/mission_status &
MONITOR_PID=$!

# 等待任务完成
echo "等待任务完成..."
sleep 180

# 停止监控
kill $MONITOR_PID 2>/dev/null

echo "=== 完整飞行任务测试完成 ==="
```

### 性能测试

#### 测试5: 系统性能基准测试
```bash
#!/bin/bash
# 测试文件: test_performance.sh

echo "=== 系统性能基准测试 ==="

# 1. 启动时间测试
echo "测试系统启动时间..."
START_TIME=$(date +%s)
./mission_planning.sh &
sleep 2

# 等待关键节点启动
while [ $(rosnode list 2>/dev/null | wc -l) -lt 6 ]; do
    sleep 1
done

END_TIME=$(date +%s)
STARTUP_TIME=$((END_TIME - START_TIME))
echo "系统启动时间: ${STARTUP_TIME}秒 (目标: <45秒)"

# 2. 内存使用测试
echo "测试内存使用..."
sleep 10
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')
ROS_MEMORY=$(ps aux | grep ros | awk '{sum+=$6} END {printf "%.0f", sum/1024}')
echo "系统内存使用: ${MEMORY_USAGE}"
echo "ROS节点内存: ${ROS_MEMORY}MB (目标: <1000MB)"

# 3. CPU使用率测试
echo "测试CPU使用率..."
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "CPU使用率: ${CPU_USAGE}% (目标: <50%)"

# 4. 通信延迟测试
echo "测试通信延迟..."
echo "测试MQTT通信延迟..."
MQTT_START=$(date +%s%N)
mosquitto_pub -h localhost -t "test/latency" -m "ping"
sleep 1
MQTT_END=$(date +%s%N)
MQTT_LATENCY=$(((MQTT_END - MQTT_START) / 1000000))
echo "MQTT延迟: ${MQTT_LATENCY}ms (目标: <100ms)"

# 5. 数据更新频率测试
echo "测试数据更新频率..."
echo "测试状态估计频率..."
STATE_HZ=$(rostopic hz /uav1/uav_state 2>/dev/null | tail -1 | awk '{print $2}')
echo "状态更新频率: ${STATE_HZ}Hz (目标: >30Hz)"

echo "测试ArUco检测频率..."
ARUCO_HZ=$(timeout 10 rostopic hz /aruco_detection/pose 2>/dev/null | tail -1 | awk '{print $2}')
echo "ArUco检测频率: ${ARUCO_HZ}Hz (目标: >10Hz)"

echo "=== 性能测试完成 ==="
```

## 🐛 故障排除

### 常见问题诊断

#### 问题1: GPS信号不稳定
**症状**: GPS卫星数量少，定位精度差
```bash
# 诊断步骤
rostopic echo /mavros/global_position/global
rostopic echo /mavros/gps/fix

# 解决方案
# 1. 移动到空旷区域
# 2. 检查GPS天线朝向
# 3. 等待GPS信号稳定
# 4. 考虑使用RTK基站
```

#### 问题2: 任务执行失败
**症状**: 航点任务无法正常执行
```bash
# 诊断步骤
rostopic echo /mavros/mission/waypoints
rostopic echo /uav1/mission_status

# 检查飞控模式
rostopic echo /mavros/state | grep mode

# 解决方案
# 1. 确认飞控处于AUTO.MISSION模式
# 2. 检查任务格式正确性
# 3. 验证地理围栏设置
# 4. 检查安全检查设置
```

#### 问题3: ArUco检测失效
**症状**: 无法检测到ArUco标记
```bash
# 诊断步骤
rosrun image_view image_view image:=/usb_cam/image_raw
rostopic echo /aruco_detection/pose

# 检查标记质量
# 1. 标记是否清晰完整
# 2. 光照条件是否合适
# 3. 相机焦距是否正确
# 4. 检测距离是否合理

# 解决方案
# 1. 调整相机位置和角度
# 2. 改善光照条件
# 3. 使用更大尺寸的标记
# 4. 重新标定相机参数
```

## 📊 性能指标

### 系统性能指标
- **启动时间**: <45秒
- **内存使用**: <1GB
- **CPU使用率**: <50%
- **任务响应延迟**: <500ms

### 导航精度指标
- **GPS水平精度**: ±2m (标准GPS), ±0.3m (RTK)
- **高度精度**: ±1m
- **航点到达精度**: ±5m
- **ArUco降落精度**: ±10cm

### 可靠性指标
- **任务成功率**: >95%
- **通信成功率**: >99%
- **系统稳定运行时间**: >2小时

## 📚 扩展开发

### 自定义任务类型
```python
# 自定义任务生成器
def generate_survey_mission(area_bounds, altitude=50, overlap=0.7):
    """生成测绘任务航点"""
    waypoints = []
    # 计算航点间距
    spacing = calculate_spacing(altitude, overlap)
    # 生成栅格航点
    for x in range(area_bounds['x_min'], area_bounds['x_max'], spacing):
        for y in range(area_bounds['y_min'], area_bounds['y_max'], spacing):
            waypoint = {
                "frame": 0,  # GPS坐标
                "command": 16,  # NAV_WAYPOINT
                "x": x, "y": y, "z": altitude,
                "param1": 3.0  # 悬停时间
            }
            waypoints.append(waypoint)
    return waypoints
```

### 高级任务管理
```bash
# 任务模板管理
mkdir -p mission_templates
cp complex_mission.json mission_templates/survey_template.json
cp test_simple_mission.json mission_templates/basic_template.json

# 任务执行监控
rostopic echo /uav1/mission_status | while read line; do
    echo "$(date): $line" >> mission_execution.log
done
```

## 📜 许可证

本模块遵循 MIT 许可证

## 👥 维护者

- **负责人**: UAV控制实验室
- **模块**: 航线规划与任务执行

---

💡 **提示**: 执行实机飞行测试前，请务必完成所有仿真测试，并确保安全飞行条件。 