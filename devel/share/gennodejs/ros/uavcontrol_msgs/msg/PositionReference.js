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

class PositionReference {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.Move_mode = null;
      this.Move_frame = null;
      this.time_from_start = null;
      this.position_ref = null;
      this.velocity_ref = null;
      this.acceleration_ref = null;
      this.yaw_ref = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Move_mode')) {
        this.Move_mode = initObj.Move_mode
      }
      else {
        this.Move_mode = 0;
      }
      if (initObj.hasOwnProperty('Move_frame')) {
        this.Move_frame = initObj.Move_frame
      }
      else {
        this.Move_frame = 0;
      }
      if (initObj.hasOwnProperty('time_from_start')) {
        this.time_from_start = initObj.time_from_start
      }
      else {
        this.time_from_start = 0.0;
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PositionReference
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [Move_mode]
    bufferOffset = _serializer.uint8(obj.Move_mode, buffer, bufferOffset);
    // Serialize message field [Move_frame]
    bufferOffset = _serializer.uint8(obj.Move_frame, buffer, bufferOffset);
    // Serialize message field [time_from_start]
    bufferOffset = _serializer.float32(obj.time_from_start, buffer, bufferOffset);
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
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PositionReference
    let len;
    let data = new PositionReference(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Move_mode]
    data.Move_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Move_frame]
    data.Move_frame = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [time_from_start]
    data.time_from_start = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [position_ref]
    data.position_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [velocity_ref]
    data.velocity_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [acceleration_ref]
    data.acceleration_ref = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [yaw_ref]
    data.yaw_ref = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 46;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/PositionReference';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5aa100275600b3aa2239f15be9b50ba5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 位置控制参考量
    
    ## 默认为 XYZ位置追踪模式 （sub_mode = 0）； 速度追踪启用时，控制器不考虑位置参考量及位置状态反馈
    uint8 Move_mode
    
    uint8 XYZ_POS      = 0  ##0b00
    uint8 XY_POS_Z_VEL = 1  ##0b01
    uint8 XY_VEL_Z_POS = 2  ##0b10
    uint8 XYZ_VEL = 3       ##0b11
    uint8 XYZ_ACC = 4
    uint8 TRAJECTORY   = 5  
    
    uint8 Move_frame
    # 默认情况下均为ENU_FRAME,注意轨迹追踪和XYZ_ACC一定是ENU_FRAME
    uint8 ENU_FRAME  = 0
    uint8 BODY_FRAME = 1
    uint8 MIX_FRAME = 2 ##2020.4.6 临时增加的模式，后期需要统一整合，该模式下，xy采用机体系控制，z采用enu系控制
    
    ## 时刻： 用于轨迹追踪
    float32 time_from_start          ## [s]
    
    ## 参考量：位置、速度、加速度、加加速度、加加加速度
    float32[3] position_ref          ## [m]
    float32[3] velocity_ref          ## [m/s]
    float32[3] acceleration_ref      ## [m/s^2]
    ## float32[3] jerk_ref              ## [m/s^3]
    ## float32[3] snap_ref              ## [m/s^4]
    
    ## 角度参考量：偏航角、偏航角速度、偏航角加速度
    float32 yaw_ref                  ## [rad]
    ## float32 yaw_rate_ref             ## [rad/s] 
    ## float32 yaw_acceleration_ref     ## [rad/s] 
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
    const resolved = new PositionReference(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.Move_mode !== undefined) {
      resolved.Move_mode = msg.Move_mode;
    }
    else {
      resolved.Move_mode = 0
    }

    if (msg.Move_frame !== undefined) {
      resolved.Move_frame = msg.Move_frame;
    }
    else {
      resolved.Move_frame = 0
    }

    if (msg.time_from_start !== undefined) {
      resolved.time_from_start = msg.time_from_start;
    }
    else {
      resolved.time_from_start = 0.0
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

    return resolved;
    }
};

// Constants for message
PositionReference.Constants = {
  XYZ_POS: 0,
  XY_POS_Z_VEL: 1,
  XY_VEL_Z_POS: 2,
  XYZ_VEL: 3,
  XYZ_ACC: 4,
  TRAJECTORY: 5,
  ENU_FRAME: 0,
  BODY_FRAME: 1,
  MIX_FRAME: 2,
}

module.exports = PositionReference;
