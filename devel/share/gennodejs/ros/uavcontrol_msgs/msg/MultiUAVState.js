// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let UAVState = require('./UAVState.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MultiUAVState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.uav_num = null;
      this.uav_state_all = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('uav_num')) {
        this.uav_num = initObj.uav_num
      }
      else {
        this.uav_num = 0;
      }
      if (initObj.hasOwnProperty('uav_state_all')) {
        this.uav_state_all = initObj.uav_state_all
      }
      else {
        this.uav_state_all = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MultiUAVState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [uav_num]
    bufferOffset = _serializer.int32(obj.uav_num, buffer, bufferOffset);
    // Serialize message field [uav_state_all]
    // Serialize the length for message field [uav_state_all]
    bufferOffset = _serializer.uint32(obj.uav_state_all.length, buffer, bufferOffset);
    obj.uav_state_all.forEach((val) => {
      bufferOffset = UAVState.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MultiUAVState
    let len;
    let data = new MultiUAVState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [uav_num]
    data.uav_num = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [uav_state_all]
    // Deserialize array length for message field [uav_state_all]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.uav_state_all = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.uav_state_all[i] = UAVState.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.uav_state_all.forEach((val) => {
      length += UAVState.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/MultiUAVState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '72627e48e74480de1a52aedffff0dfea';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 
    int32 uav_num
    
    ## 从1开始
    UAVState[] uav_state_all
    
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
    
    ================================================================================
    MSG: uavcontrol_msgs/UAVState
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
    
    
    
        
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MultiUAVState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.uav_num !== undefined) {
      resolved.uav_num = msg.uav_num;
    }
    else {
      resolved.uav_num = 0
    }

    if (msg.uav_state_all !== undefined) {
      resolved.uav_state_all = new Array(msg.uav_state_all.length);
      for (let i = 0; i < resolved.uav_state_all.length; ++i) {
        resolved.uav_state_all[i] = UAVState.Resolve(msg.uav_state_all[i]);
      }
    }
    else {
      resolved.uav_state_all = []
    }

    return resolved;
    }
};

module.exports = MultiUAVState;
