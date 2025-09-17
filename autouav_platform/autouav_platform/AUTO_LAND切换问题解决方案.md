# PX4 AUTO.LAND切换问题解决方案

## 🔍 问题分析

您遇到的问题：
1. **高度达到阈值但未切换到AUTO.LAND模式**
2. **OFFBOARD模式锁定，遥控器无法接管**
3. **激光雷达高度源可能与PX4内部高度不一致**

## 💡 解决方案

### 方案1：改进的AUTO.LAND切换机制

#### 1.1 多重试机制
- AUTO.LAND指令发送失败时自动重试（最多5次）
- 每次重试间隔2秒
- 监控模式切换结果

#### 1.2 改进的executePx4LandMode()
```cpp
void executePx4LandMode() {
    // 多次尝试发送LAND指令
    // 监控模式切换状态
    // 失败时保持当前控制模式
}
```

### 方案2：多种AUTO.LAND触发方式

#### 2.1 传统高度触发（默认）
```yaml
autoland_trigger:
  enable_height_trigger: true  # 启用高度触发
```

#### 2.2 时间触发（推荐用于您的情况）
```yaml
autoland_trigger:
  enable_time_trigger: true         # 启用时间触发
  auto_land_time_threshold: 15.0    # 精降落15秒后自动切换
```

#### 2.3 精度触发
```yaml
autoland_trigger:
  enable_accuracy_trigger: true          # 启用精度触发
  position_accuracy_threshold: 0.05      # 位置误差小于5%时触发
```

#### 2.4 手动触发（最灵活）
```bash
# 在任何时候手动触发AUTO.LAND
rostopic pub /manual_autoland_trigger std_msgs/Bool "data: true"
```

## 🛠️ 立即可用的解决方法

### 方法1：禁用高度触发，启用手动触发
```yaml
# 修改 aruco_land_params.yaml
autoland_trigger:
  enable_height_trigger: false    # 禁用高度触发
  enable_time_trigger: false      # 禁用时间触发
  enable_accuracy_trigger: false  # 禁用精度触发
```

然后在需要时手动触发：
```bash
rostopic pub /manual_autoland_trigger std_msgs/Bool "data: true"
```

### 方法2：使用时间触发代替高度触发
```yaml
autoland_trigger:
  enable_height_trigger: false    # 禁用高度触发
  enable_time_trigger: true       # 启用时间触发
  auto_land_time_threshold: 20.0  # 精降落20秒后自动切换
```

### 方法3：调整高度阈值
```yaml
# 将高度阈值设置得更高，确保激光雷达数据准确时才切换
height_fine_land: 0.2  # 从0.5米降低到0.2米
```

## 🔧 调试步骤

### 第一步：检查高度数据源
```bash
# 检查激光雷达数据
rostopic echo /uav2/mavros/distance_sensor/hrlv_ez4_pub

# 检查GPS相对高度
rostopic echo /uav2/mavros/global_position/rel_alt

# 检查本地位置高度
rostopic echo /uav2/mavros/local_position/pose
```

### 第二步：监控模式切换
```bash
# 监控飞行模式变化
rostopic echo /uav2/mavros/state

# 查看系统日志
rostopic echo /rosout | grep -i "land\|px4\|height"
```

### 第三步：测试手动触发
```bash
# 在降落过程中手动触发AUTO.LAND
rostopic pub /manual_autoland_trigger std_msgs/Bool "data: true"
```

## 🚨 紧急处理方法

### 方法1：立即切换到POSITION模式（允许遥控器接管）
```bash
rosservice call /uav2/mavros/set_mode "custom_mode: 'POSITION'"
```

### 方法2：停止二维码降落
```bash
rostopic pub /aruco_landing std_msgs/Bool "data: false"
```

### 方法3：强制切换到LAND模式
```bash
rosservice call /uav2/mavros/set_mode "custom_mode: 'AUTO.LAND'"
```

## 📋 推荐配置

### 配置1：手动控制（最安全）
```yaml
autoland_trigger:
  enable_height_trigger: false
  enable_time_trigger: false  
  enable_accuracy_trigger: false
```
使用方法：手动发送 `/manual_autoland_trigger` 话题

### 配置2：时间触发（较安全）
```yaml
autoland_trigger:
  enable_height_trigger: false
  enable_time_trigger: true
  auto_land_time_threshold: 20.0  # 20秒后自动切换
```

### 配置3：多条件触发（最智能）
```yaml
autoland_trigger:
  enable_height_trigger: true
  enable_time_trigger: true
  enable_accuracy_trigger: true
  auto_land_time_threshold: 30.0
  position_accuracy_threshold: 0.03
```

## 🎯 使用建议

1. **立即解决当前问题**：
   - 禁用高度触发：`enable_height_trigger: false`
   - 使用手动触发：`rostopic pub /manual_autoland_trigger std_msgs/Bool "data: true"`

2. **长期改进**：
   - 校准激光雷达与PX4高度数据的一致性
   - 使用时间触发作为备用方案
   - 添加遥控器接管检测

3. **测试验证**：
   - 在安全环境中测试各种触发方式
   - 验证模式切换的可靠性
   - 确认遥控器接管功能正常

这些改进让您有多种方式来控制AUTO.LAND的切换，不再完全依赖高度阈值，同时提供了更好的故障处理和安全保护。
