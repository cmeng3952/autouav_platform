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
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class UAVState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.uav_id = null;
      this.connected = null;
      this.armed = null;
      this.mode = null;
      this.location_source = null;
      this.odom_valid = null;
      this.gps_status = null;
      this.gps_num = null;
      this.position = null;
      this.range = null;
      this.latitude = null;
      this.longitude = null;
      this.altitude = null;
      this.rel_alt = null;
      this.velocity = null;
      this.attitude = null;
      this.attitude_rpy = null;
      this.attitude_q = null;
      this.attitude_rate = null;
      this.battery_state = null;
      this.battery_percetage = null;
      this.landed = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('uav_id')) {
        this.uav_id = initObj.uav_id
      }
      else {
        this.uav_id = 0;
      }
      if (initObj.hasOwnProperty('connected')) {
        this.connected = initObj.connected
      }
      else {
        this.connected = false;
      }
      if (initObj.hasOwnProperty('armed')) {
        this.armed = initObj.armed
      }
      else {
        this.armed = false;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = '';
      }
      if (initObj.hasOwnProperty('location_source')) {
        this.location_source = initObj.location_source
      }
      else {
        this.location_source = 0;
      }
      if (initObj.hasOwnProperty('odom_valid')) {
        this.odom_valid = initObj.odom_valid
      }
      else {
        this.odom_valid = false;
      }
      if (initObj.hasOwnProperty('gps_status')) {
        this.gps_status = initObj.gps_status
      }
      else {
        this.gps_status = 0;
      }
      if (initObj.hasOwnProperty('gps_num')) {
        this.gps_num = initObj.gps_num
      }
      else {
        this.gps_num = 0;
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('range')) {
        this.range = initObj.range
      }
      else {
        this.range = 0.0;
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
      if (initObj.hasOwnProperty('rel_alt')) {
        this.rel_alt = initObj.rel_alt
      }
      else {
        this.rel_alt = 0.0;
      }
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('attitude')) {
        this.attitude = initObj.attitude
      }
      else {
        this.attitude = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('attitude_rpy')) {
        this.attitude_rpy = initObj.attitude_rpy
      }
      else {
        this.attitude_rpy = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('attitude_q')) {
        this.attitude_q = initObj.attitude_q
      }
      else {
        this.attitude_q = new geometry_msgs.msg.Quaternion();
      }
      if (initObj.hasOwnProperty('attitude_rate')) {
        this.attitude_rate = initObj.attitude_rate
      }
      else {
        this.attitude_rate = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('battery_state')) {
        this.battery_state = initObj.battery_state
      }
      else {
        this.battery_state = 0.0;
      }
      if (initObj.hasOwnProperty('battery_percetage')) {
        this.battery_percetage = initObj.battery_percetage
      }
      else {
        this.battery_percetage = 0.0;
      }
      if (initObj.hasOwnProperty('landed')) {
        this.landed = initObj.landed
      }
      else {
        this.landed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UAVState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [uav_id]
    bufferOffset = _serializer.uint8(obj.uav_id, buffer, bufferOffset);
    // Serialize message field [connected]
    bufferOffset = _serializer.bool(obj.connected, buffer, bufferOffset);
    // Serialize message field [armed]
    bufferOffset = _serializer.bool(obj.armed, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.string(obj.mode, buffer, bufferOffset);
    // Serialize message field [location_source]
    bufferOffset = _serializer.uint8(obj.location_source, buffer, bufferOffset);
    // Serialize message field [odom_valid]
    bufferOffset = _serializer.bool(obj.odom_valid, buffer, bufferOffset);
    // Serialize message field [gps_status]
    bufferOffset = _serializer.uint8(obj.gps_status, buffer, bufferOffset);
    // Serialize message field [gps_num]
    bufferOffset = _serializer.uint8(obj.gps_num, buffer, bufferOffset);
    // Check that the constant length array field [position] has the right length
    if (obj.position.length !== 3) {
      throw new Error('Unable to serialize array field position - length must be 3')
    }
    // Serialize message field [position]
    bufferOffset = _arraySerializer.float32(obj.position, buffer, bufferOffset, 3);
    // Serialize message field [range]
    bufferOffset = _serializer.float32(obj.range, buffer, bufferOffset);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float32(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float32(obj.longitude, buffer, bufferOffset);
    // Serialize message field [altitude]
    bufferOffset = _serializer.float32(obj.altitude, buffer, bufferOffset);
    // Serialize message field [rel_alt]
    bufferOffset = _serializer.float32(obj.rel_alt, buffer, bufferOffset);
    // Check that the constant length array field [velocity] has the right length
    if (obj.velocity.length !== 3) {
      throw new Error('Unable to serialize array field velocity - length must be 3')
    }
    // Serialize message field [velocity]
    bufferOffset = _arraySerializer.float32(obj.velocity, buffer, bufferOffset, 3);
    // Check that the constant length array field [attitude] has the right length
    if (obj.attitude.length !== 3) {
      throw new Error('Unable to serialize array field attitude - length must be 3')
    }
    // Serialize message field [attitude]
    bufferOffset = _arraySerializer.float32(obj.attitude, buffer, bufferOffset, 3);
    // Check that the constant length array field [attitude_rpy] has the right length
    if (obj.attitude_rpy.length !== 3) {
      throw new Error('Unable to serialize array field attitude_rpy - length must be 3')
    }
    // Serialize message field [attitude_rpy]
    bufferOffset = _arraySerializer.float32(obj.attitude_rpy, buffer, bufferOffset, 3);
    // Serialize message field [attitude_q]
    bufferOffset = geometry_msgs.msg.Quaternion.serialize(obj.attitude_q, buffer, bufferOffset);
    // Check that the constant length array field [attitude_rate] has the right length
    if (obj.attitude_rate.length !== 3) {
      throw new Error('Unable to serialize array field attitude_rate - length must be 3')
    }
    // Serialize message field [attitude_rate]
    bufferOffset = _arraySerializer.float32(obj.attitude_rate, buffer, bufferOffset, 3);
    // Serialize message field [battery_state]
    bufferOffset = _serializer.float32(obj.battery_state, buffer, bufferOffset);
    // Serialize message field [battery_percetage]
    bufferOffset = _serializer.float32(obj.battery_percetage, buffer, bufferOffset);
    // Serialize message field [landed]
    bufferOffset = _serializer.bool(obj.landed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UAVState
    let len;
    let data = new UAVState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [uav_id]
    data.uav_id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [connected]
    data.connected = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [armed]
    data.armed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [location_source]
    data.location_source = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [odom_valid]
    data.odom_valid = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [gps_status]
    data.gps_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [gps_num]
    data.gps_num = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [range]
    data.range = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [altitude]
    data.altitude = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rel_alt]
    data.rel_alt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [attitude]
    data.attitude = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [attitude_rpy]
    data.attitude_rpy = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [attitude_q]
    data.attitude_q = geometry_msgs.msg.Quaternion.deserialize(buffer, bufferOffset);
    // Deserialize message field [attitude_rate]
    data.attitude_rate = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [battery_state]
    data.battery_state = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [battery_percetage]
    data.battery_percetage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [landed]
    data.landed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.mode);
    return length + 132;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/UAVState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '14fa9d3d6abb647e889d626f088b2192';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new UAVState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.uav_id !== undefined) {
      resolved.uav_id = msg.uav_id;
    }
    else {
      resolved.uav_id = 0
    }

    if (msg.connected !== undefined) {
      resolved.connected = msg.connected;
    }
    else {
      resolved.connected = false
    }

    if (msg.armed !== undefined) {
      resolved.armed = msg.armed;
    }
    else {
      resolved.armed = false
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = ''
    }

    if (msg.location_source !== undefined) {
      resolved.location_source = msg.location_source;
    }
    else {
      resolved.location_source = 0
    }

    if (msg.odom_valid !== undefined) {
      resolved.odom_valid = msg.odom_valid;
    }
    else {
      resolved.odom_valid = false
    }

    if (msg.gps_status !== undefined) {
      resolved.gps_status = msg.gps_status;
    }
    else {
      resolved.gps_status = 0
    }

    if (msg.gps_num !== undefined) {
      resolved.gps_num = msg.gps_num;
    }
    else {
      resolved.gps_num = 0
    }

    if (msg.position !== undefined) {
      resolved.position = msg.position;
    }
    else {
      resolved.position = new Array(3).fill(0)
    }

    if (msg.range !== undefined) {
      resolved.range = msg.range;
    }
    else {
      resolved.range = 0.0
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

    if (msg.rel_alt !== undefined) {
      resolved.rel_alt = msg.rel_alt;
    }
    else {
      resolved.rel_alt = 0.0
    }

    if (msg.velocity !== undefined) {
      resolved.velocity = msg.velocity;
    }
    else {
      resolved.velocity = new Array(3).fill(0)
    }

    if (msg.attitude !== undefined) {
      resolved.attitude = msg.attitude;
    }
    else {
      resolved.attitude = new Array(3).fill(0)
    }

    if (msg.attitude_rpy !== undefined) {
      resolved.attitude_rpy = msg.attitude_rpy;
    }
    else {
      resolved.attitude_rpy = new Array(3).fill(0)
    }

    if (msg.attitude_q !== undefined) {
      resolved.attitude_q = geometry_msgs.msg.Quaternion.Resolve(msg.attitude_q)
    }
    else {
      resolved.attitude_q = new geometry_msgs.msg.Quaternion()
    }

    if (msg.attitude_rate !== undefined) {
      resolved.attitude_rate = msg.attitude_rate;
    }
    else {
      resolved.attitude_rate = new Array(3).fill(0)
    }

    if (msg.battery_state !== undefined) {
      resolved.battery_state = msg.battery_state;
    }
    else {
      resolved.battery_state = 0.0
    }

    if (msg.battery_percetage !== undefined) {
      resolved.battery_percetage = msg.battery_percetage;
    }
    else {
      resolved.battery_percetage = 0.0
    }

    if (msg.landed !== undefined) {
      resolved.landed = msg.landed;
    }
    else {
      resolved.landed = false
    }

    return resolved;
    }
};

// Constants for message
UAVState.Constants = {
  MOCAP: 0,
  T265: 1,
  GAZEBO: 2,
  FAKE_ODOM: 3,
  GPS: 4,
  RTK: 5,
  UWB: 6,
  VINS: 7,
  OPTICAL_FLOW: 8,
  VIOBOT: 9,
  MID360: 10,
  BSA_SLAM: 11,
  GPS_FIX_TYPE_NO_GPS: 0,
  GPS_FIX_TYPE_NO_FIX: 1,
  GPS_FIX_TYPE_2D_FIX: 2,
  GPS_FIX_TYPE_3D_FIX: 3,
  GPS_FIX_TYPE_DGPS: 4,
  GPS_FIX_TYPE_RTK_FLOATR: 5,
  GPS_FIX_TYPE_RTK_FIXEDR: 6,
  GPS_FIX_TYPE_STATIC: 7,
  GPS_FIX_TYPE_PPP: 8,
}

module.exports = UAVState;
