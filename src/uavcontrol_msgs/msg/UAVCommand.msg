std_msgs/Header header

## ---------------------------------控制命令的模式 ------------------------------
uint8 Agent_CMD
uint8 Takeoff=1           #起飞
uint8 Land=2              #降落
uint8 RTL=3               #返航
uint8 Move=4              #移动
uint8 User_Mode=5         #模式
uint8 Init_Pos_Hover=6    # home点上方悬停
uint8 Current_Pos_Hover=7 # 当前位置上方悬停
uint8 Mission=8           #自主巡航
uint8 aruco_land=9        #二维码识别降落


## ---------------------------------------控制等级 -------------------------------
uint8 Control_Level
uint8 DEFAULT_CONTROL=0        ### 默认控制
uint8 ABSOLUTE_CONTROL=1       ### 绝对控制，持续的Move模式应谨慎使用该优先级
uint8 EXIT_ABSOLUTE_CONTROL=2  ### 退出绝对控制控制，在该控制下，会响应上述两种控制的指令

## 移动命令下的子模式
uint8 Move_mode
uint8 XYZ_POS = 0               ### 惯性系定点控制
uint8 XY_VEL_Z_POS = 1          ### 惯性系定高速度控制
uint8 XYZ_VEL = 2               ### 惯性系速度控制
uint8 XYZ_POS_BODY = 3          ### 机体系位置控制
uint8 XYZ_VEL_BODY = 4          ### 机体系速度控制
uint8 XY_VEL_Z_POS_BODY = 5     ### 机体系定高速度控制
uint8 TRAJECTORY = 6            ### 轨迹追踪控制
uint8 XYZ_ATT = 7               ### 姿态控制（来自外部控制器）
uint8 LAT_LON_ALT = 8           ### 绝对坐标系下的经纬度

## 控制参考量
float32[3] position_ref                ## [m]
float32[3] velocity_ref                ## [m/s]
float32[3] acceleration_ref            ## [m/s^2]
float32 yaw_ref                        ## [rad]
float32 rtl_height                     ## [m]返航高度
bool Yaw_Rate_Mode                     ## True 代表控制偏航角速率
float32 yaw_rate_ref                   ## [rad/s]
float32[4] att_ref                     ## [rad] + [0-1]
float64 latitude                       ## 无人机经度、纬度、高度                 
float64 longitude                      ## 无人机经度、纬度、高度
float64 altitude                       ## 无人机经度、纬度、高度

## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
uint32 Command_ID





