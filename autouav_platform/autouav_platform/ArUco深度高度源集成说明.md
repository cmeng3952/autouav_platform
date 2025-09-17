# ArUco深度数据作为高度源集成说明

## 🎯 功能概述

成功集成了ArUco检测中的深度信息（`msg->targets[i].pz`）作为额外的高度数据源，提供更准确和可靠的高度估计。

## 🔧 技术实现

### 1. 数据采集
```cpp
// 在arucoCenterCallback中添加深度信息采集
aruco_depth_[i] = msg->targets[i].pz;  // 存储每个ArUco标记的深度信息
```

### 2. 高度计算优先级
```cpp
double getArucoHeight() const {
    // 优先使用中心标记（ID19, ID43）的深度
    // 备用使用四角标记的平均深度
    // 进行合理性检查（0.1m - 50.0m）
}
```

### 3. 多源融合算法
```cpp
double getMultiSourceFusedHeight() const {
    // 加权融合：ArUco深度 + 激光测距 + GPS + 本地高度
    // 可配置权重：depth_weight, lidar_weight, gps_weight
}
```

## ⚙️ 配置选项

### 高度数据源优先级
```yaml
# 新增两种模式
height_source_priority: 4  # ArUco深度优先
height_source_priority: 5  # 多源融合模式
```

### ArUco深度配置
```yaml
aruco_depth:
  enable: true                    # 启用ArUco深度数据
  min_valid_depth: 0.1           # 最小有效深度 (米)
  max_valid_depth: 50.0          # 最大有效深度 (米)
  
  # 多源融合权重配置
  depth_weight: 0.8              # ArUco深度数据权重
  lidar_weight: 0.6              # 激光测距权重
  gps_weight: 0.4                # GPS权重
  
  # 调试选项
  enable_depth_debug: true       # 启用深度调试输出
```

## 📊 高度源优先级说明

| 优先级 | 模式 | 说明 | 适用场景 |
|--------|------|------|----------|
| 0 | GPS_ONLY | 仅GPS相对高度 | GPS信号良好时 |
| 1 | LIDAR_ONLY | 仅激光测距 | 激光测距可靠时 |
| 2 | LIDAR_GPS_FUSION | 激光测距+GPS融合 | 两者都可用时 |
| 3 | LIDAR_PRIORITY | 激光测距优先，GPS备用 | 默认推荐 |
| **4** | **ARUCO_PRIORITY** | **ArUco深度优先** | **二维码清晰可见时** |
| **5** | **MULTI_SOURCE_FUSION** | **多源融合** | **最高精度需求** |

## 🎯 推荐使用方案

### 方案1：ArUco深度优先（适合您的情况）
```yaml
height_source_priority: 4  # ArUco深度优先
aruco_depth:
  enable: true
  depth_weight: 0.8
```

**优势：**
- 直接使用二维码检测的深度信息
- 与视觉检测数据同步
- 避免多传感器数据不一致问题

### 方案2：多源融合（最高精度）
```yaml
height_source_priority: 5  # 多源融合
aruco_depth:
  enable: true
  depth_weight: 0.8        # ArUco权重最高
  lidar_weight: 0.6        # 激光测距次之
  gps_weight: 0.4          # GPS最低
```

**优势：**
- 结合多个传感器数据
- 提供最高的高度估计精度
- 自动处理传感器故障

## 🔍 调试信息

### 高度比较输出
```
Height comparison: rel_alt=5.20m, local_z=5.18m, lidar=5.15m, aruco=5.22m, fused=5.19m
```

### ArUco深度详细输出
```
ArUco depths: ID19=5.18m ID43=5.22m -> Height=5.20m
```

### 数据源状态
```
ARUCO_PRIORITY (Lidar:OK, GPS:OK, ArUco:OK)
```

## 🛠️ 使用步骤

### 第一步：启用ArUco深度
```yaml
# 修改 aruco_land_params.yaml
height_source_priority: 4  # 或 5
aruco_depth:
  enable: true
```

### 第二步：测试验证
```bash
# 监控高度数据
rostopic echo /uav2/vision/aruco_detection

# 查看调试输出
rostopic echo /rosout | grep -i "height\|aruco\|depth"
```

### 第三步：参数调优
根据实际测试效果调整：
- `depth_weight`: ArUco深度数据权重
- `min_valid_depth`: 最小有效深度
- `max_valid_depth`: 最大有效深度

## 📋 测试清单

- [ ] 验证ArUco深度数据采集正常
- [ ] 检查高度计算是否使用ArUco数据
- [ ] 测试多源融合模式效果
- [ ] 验证异常数据过滤功能
- [ ] 确认调试输出信息正确

## 🚨 注意事项

### 1. 数据有效性
- ArUco深度数据可能受光照影响
- 需要进行合理性范围检查
- 建议与其他高度源对比验证

### 2. 优先级选择
- 二维码清晰时使用ArUco深度优先（模式4）
- 需要最高精度时使用多源融合（模式5）
- 保持激光测距作为备用

### 3. 调试建议
- 启用深度调试输出监控数据质量
- 比较不同高度源的一致性
- 记录异常情况进行分析

## 🎯 预期效果

1. **更准确的高度估计**：直接使用视觉检测的深度信息
2. **数据同步性**：ArUco位置和深度数据完全同步
3. **故障容错性**：多个高度源互相备份
4. **调试便利性**：详细的调试信息输出

这个实现让您可以充分利用ArUco检测中的深度信息，获得更准确的高度估计，特别是在二维码清晰可见的情况下。
