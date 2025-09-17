std_msgs/Header header

## 无人机编号 
uint8 uav_id

## 机载电脑是否连接上飞控，true已连接，false则不是
bool connected
## 是否解锁，true为已解锁，false则不是
bool armed
## PX4飞控当前飞行模式  int8
string mode
## 无人机定位来源
uint8 location_source
## 定位来源枚举
uint8 MOCAP=0
uint8 T265=1
uint8 GAZEBO=2
uint8 FAKE_ODOM=3
uint8 GPS = 4
uint8 RTK = 5
uint8 UWB = 6
uint8 VINS = 7
uint8 OPTICAL_FLOW = 8
uint8 viobot = 9
uint8 MID360 = 10
uint8 BSA_SLAM=11
## odom标志位
bool odom_valid

## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type
uint8 gps_status
## GPS状态枚举
uint8 GPS_FIX_TYPE_NO_GPS=0
uint8 GPS_FIX_TYPE_NO_FIX=1
uint8 GPS_FIX_TYPE_2D_FIX=2
uint8 GPS_FIX_TYPE_3D_FIX=3
uint8 GPS_FIX_TYPE_DGPS=4
uint8 GPS_FIX_TYPE_RTK_FLOATR=5
uint8 GPS_FIX_TYPE_RTK_FIXEDR=6
uint8 GPS_FIX_TYPE_STATIC=7
uint8 GPS_FIX_TYPE_PPP=8
## GPS卫星数量
uint8 gps_num

## 无人机位置、速度、姿态
float32[3] position                 ## [m]
## 无人机定高雷达                     ## [m]
float32  range
## 无人机经度、纬度、高度
float32 latitude                 ##经度          
float32 longitude                ##纬度   
float32 altitude                 ##海拔高度   
float32 rel_alt
## 无人机速度、姿态
float32[3] velocity                 ## [m/s]
## 无人机姿态（欧拉角、四元数）
float32[3] attitude                 ## [rad]

float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)
                                    ##[度] pitch（俯仰，下负-90度——上正90度）
                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）
                    
geometry_msgs/Quaternion attitude_q ## 四元数
## 无人机姿态角速度
float32[3] attitude_rate            ## [rad/s]
## 无人机电池状态
float32 battery_state               ## [V]
float32 battery_percetage           ## [0-1]

bool landed             # 着陆标志


# 飞行阶段状态
string flight_phase  
# - WAITING_FOR_TAKEOFF：等待起飞                       （有数据、未解锁、地面待命）
# - TAKING_OFF：起飞中                                               （解锁、TAKEOFF模式）
# - IN_AIR：飞行中                                                       （解锁、正常模式如POSCTL/ALTCTL）
# - RETURNING： 返航中                                               （  解锁、RTL模式）
# - LANDING：降落中                                                     （LAND模式，无论是否解锁）
# - GROUND：地面锁定                                                    （无数据状态）
# - DATA_ERROR：数据异常                                          （传感器/定位故障）


# 瞬时无人机状态标志（一次触发，保持5秒）
bool takeoff_completed      #起飞完成
bool landing_completed      #降落完成
bool prop_folded_state    #桨叶收纳完成标志



## 航点任务相关信息
bool mission_active                 ## 是否正在执行航点任务
uint16 current_waypoint             ## 当前航点序号（-1表示无航点任务）
uint16 total_waypoints              ## 总航点数量
uint16 last_reached_waypoint        ## 最后到达的航点序号（-1表示尚未到达任何航点）
string mission_state                ## 任务状态：IDLE, UPLOADING, ARMED, MISSION_ACTIVE, MISSION_COMPLETE, RTL_MODE, ARUCO_LANDING, ERROR

    
