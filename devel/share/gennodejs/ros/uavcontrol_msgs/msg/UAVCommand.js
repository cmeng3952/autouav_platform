// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class UAVCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.Agent_CMD = null;
      this.Control_Level = null;
      this.Move_mode = null;
      this.position_ref = null;
      this.velocity_ref = null;
      this.acceleration_ref = null;
      this.yaw_ref = null;
      this.rtl_height = null;
      this.land_speed = null;
      this.Yaw_Rate_Mode = null;
      this.yaw_rate_ref = null;
      this.att_ref = null;
      this.latitude = null;
      this.longitude = null;
      this.altitude = null;
      this.Command_ID = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Agent_CMD')) {
        this.Agent_CMD = initObj.Agent_CMD
      }
      else {
        this.Agent_CMD = 0;
      }
      if (initObj.hasOwnProperty('Control_Level')) {
        this.Control_Level = initObj.Control_Level
      }
      else {
        this.Control_Level = 0;
      }
      if (initObj.hasOwnProperty('Move_mode')) {
        this.Move_mode = initObj.Move_mode
      }
      else {
        this.Move_mode = 0;
      }
      if (initObj.hasOwnProperty('position_ref')) {
        this.position_ref = initObj.position_ref
      }
      else {
        this.position_ref = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('velocity_ref')) {
        this.velocity_ref = initObj.velocity_ref
      }
      else {
        this.velocity_ref = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('acceleration_ref')) {
        this.acceleration_ref = initObj.acceleration_ref
      }
      else {
        this.acceleration_ref = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('yaw_ref')) {
        this.yaw_ref = initObj.yaw_ref
      }
      else {
        this.yaw_ref = 0.0;
      }
      if (initObj.hasOwnProperty('rtl_height')) {
        this.rtl_height = initObj.rtl_height
      }
      else {
        this.rtl_height = 0.0;
      }
      if (initObj.hasOwnProperty('land_speed')) {
        this.land_speed = initObj.land_speed
      }
      else {
        this.land_speed = 0.0;
      }
      if (initObj.hasOwnProperty('Yaw_Rate_Mode')) {
        this.Yaw_Rate_Mode = initObj.Yaw_Rate_Mode
      }
      else {
        this.Yaw_Rate_Mode = false;
      }
      if (initObj.hasOwnProperty('yaw_rate_ref')) {
        this.yaw_rate_ref = initObj.yaw_rate_ref
      }
      else {
        this.yaw_rate_ref = 0.0;
      }
      if (initObj.hasOwnProperty('att_ref')) {
        this.att_ref = initObj.att_ref
      }
      else {
        this.att_ref = new Array(4).fill(0);
      }
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('altitude')) {
        this.altitude = initObj.altitude
      }
      else {
        this.altitude = 0.0;
      }
      if (initObj.hasOwnProperty('Command_ID')) {
        this.Command_ID = initObj.Command_ID
      }
      else {
        this.Command_ID = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UAVCommand
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [Agent_CMD]
    bufferOffset = _serializer.uint8(obj.Agent_CMD, buffer, bufferOffset);
    // Serialize message field [Control_Level]
    bufferOffset = _serializer.uint8(obj.Control_Level, buffer, bufferOffset);
    // Serialize message field [Move_mode]
    bufferOffset = _serializer.uint8(obj.Move_mode, buffer, bufferOffset);
    // Check that the constant length array field [position_ref] has the right length
    if (obj.position_ref.length !== 3) {
      throw new Error('Unable to serialize array field position_ref - length must be 3')
    }
    // Serialize message field [position_ref]
    bufferOffset = _arraySerializer.float32(obj.position_ref, buffer, bufferOffset, 3);
    // Check that the constant length array field [velocity_ref] has the right length
    if (obj.velocity_ref.length !== 3) {
      throw new Error('Unable to serialize array field velocity_ref - length must be 3')
    }
    // Serialize message field [velocity_ref]
    bufferOffset = _arraySerializer.float32(obj.velocity_ref, buffer, bufferOffset, 3);
    // Check that the constant length array field [acceleration_ref] has the right length
    if (obj.acceleration_ref.length !== 3) {
      throw new Error('Unable to serialize array field acceleration_ref - length must be 3')
    }
    // Serialize message field [acceleration_ref]
    bufferOffset = _arraySerializer.float32(obj.acceleration_ref, buffer, bufferOffset, 3);
    // Serialize message field [yaw_ref]
    bufferOffset = _serializer.float32(obj.yaw_ref, buffer, bufferOffset);
    // Serialize message field [rtl_height]
    bufferOffset = _serializer.float32(obj.rtl_height, buffer, bufferOffset);
    // Serialize message field [land_speed]
    bufferOffset = _serializer.float32(obj.land_speed, buffer, bufferOffset);
    // Serialize message field [Yaw_Rate_Mode]
    bufferOffset = _serializer.bool(obj.Yaw_Rate_Mode, buffer, bufferOffset);
    // Serialize message field [yaw_rate_ref]
    bufferOffset = _serializer.float32(obj.yaw_rate_ref, buffer, bufferOffset);
    // Check that the constant length array field [att_ref] has the right length
    if (obj.att_ref.length !== 4) {
      throw new Error('Unable to serialize array field att_ref - length must be 4')
    }
    // Serialize message field [att_ref]
    bufferOffset = _arraySerializer.float32(obj.att_ref, buffer, bufferOffset, 4);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float64(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float64(obj.longitude, buffer, bufferOffset);
    // Serialize message field [altitude]
    bufferOffset = _serializer.float64(obj.altitude, buffer, bufferOffset);
    // Serialize message field [Command_ID]
    bufferOffset = _serializer.uint32(obj.Command_ID, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UAVCommand
    let len;
    let data = new UAVCommand(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Agent_CMD]
    data.Agent_CMD = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Control_Level]
    data.Control_Level = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Move_mode]
    data.Move_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [position_ref]
    data.position_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [velocity_ref]
    data.velocity_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [acceleration_ref]
    data.acceleration_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [yaw_ref]
    data.yaw_ref = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rtl_height]
    data.rtl_height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [land_speed]
    data.land_speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [Yaw_Rate_Mode]
    data.Yaw_Rate_Mode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [yaw_rate_ref]
    data.yaw_rate_ref = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [att_ref]
    data.att_ref = _arrayDeserializer.float32(buffer, bufferOffset, 4)
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [altitude]
    data.altitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [Command_ID]
    data.Command_ID = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 100;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/UAVCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fd7212149442985f53521ffb85dcaa16';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    float32 land_speed
    bool Yaw_Rate_Mode                     ## True 代表控制偏航角速率
    float32 yaw_rate_ref                   ## [rad/s]
    float32[4] att_ref                     ## [rad] + [0-1]
    float64 latitude                       ## 无人机经度、纬度、高度                 
    float64 longitude                      ## 无人机经度、纬度、高度
    float64 altitude                       ## 无人机经度、纬度、高度
    
    ## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
    uint32 Command_ID
    
    
    
    
    
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new UAVCommand(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.Agent_CMD !== undefined) {
      resolved.Agent_CMD = msg.Agent_CMD;
    }
    else {
      resolved.Agent_CMD = 0
    }

    if (msg.Control_Level !== undefined) {
      resolved.Control_Level = msg.Control_Level;
    }
    else {
      resolved.Control_Level = 0
    }

    if (msg.Move_mode !== undefined) {
      resolved.Move_mode = msg.Move_mode;
    }
    else {
      resolved.Move_mode = 0
    }

    if (msg.position_ref !== undefined) {
      resolved.position_ref = msg.position_ref;
    }
    else {
      resolved.position_ref = new Array(3).fill(0)
    }

    if (msg.velocity_ref !== undefined) {
      resolved.velocity_ref = msg.velocity_ref;
    }
    else {
      resolved.velocity_ref = new Array(3).fill(0)
    }

    if (msg.acceleration_ref !== undefined) {
      resolved.acceleration_ref = msg.acceleration_ref;
    }
    else {
      resolved.acceleration_ref = new Array(3).fill(0)
    }

    if (msg.yaw_ref !== undefined) {
      resolved.yaw_ref = msg.yaw_ref;
    }
    else {
      resolved.yaw_ref = 0.0
    }

    if (msg.rtl_height !== undefined) {
      resolved.rtl_height = msg.rtl_height;
    }
    else {
      resolved.rtl_height = 0.0
    }

    if (msg.land_speed !== undefined) {
      resolved.land_speed = msg.land_speed;
    }
    else {
      resolved.land_speed = 0.0
    }

    if (msg.Yaw_Rate_Mode !== undefined) {
      resolved.Yaw_Rate_Mode = msg.Yaw_Rate_Mode;
    }
    else {
      resolved.Yaw_Rate_Mode = false
    }

    if (msg.yaw_rate_ref !== undefined) {
      resolved.yaw_rate_ref = msg.yaw_rate_ref;
    }
    else {
      resolved.yaw_rate_ref = 0.0
    }

    if (msg.att_ref !== undefined) {
      resolved.att_ref = msg.att_ref;
    }
    else {
      resolved.att_ref = new Array(4).fill(0)
    }

    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.altitude !== undefined) {
      resolved.altitude = msg.altitude;
    }
    else {
      resolved.altitude = 0.0
    }

    if (msg.Command_ID !== undefined) {
      resolved.Command_ID = msg.Command_ID;
    }
    else {
      resolved.Command_ID = 0
    }

    return resolved;
    }
};

// Constants for message
UAVCommand.Constants = {
  TAKEOFF: 1,
  LAND: 2,
  RTL: 3,
  MOVE: 4,
  USER_MODE: 5,
  INIT_POS_HOVER: 6,
  CURRENT_POS_HOVER: 7,
  MISSION: 8,
  ARUCO_LAND: 9,
  DEFAULT_CONTROL: 0,
  ABSOLUTE_CONTROL: 1,
  EXIT_ABSOLUTE_CONTROL: 2,
  XYZ_POS: 0,
  XY_VEL_Z_POS: 1,
  XYZ_VEL: 2,
  XYZ_POS_BODY: 3,
  XYZ_VEL_BODY: 4,
  XY_VEL_Z_POS_BODY: 5,
  TRAJECTORY: 6,
  XYZ_ATT: 7,
  LAT_LON_ALT: 8,
}

module.exports = UAVCommand;
