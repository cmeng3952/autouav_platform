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

class UGVCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.Command_ID = null;
      this.Mode = null;
      this.position_ref = null;
      this.yaw_ref = null;
      this.linear_vel = null;
      this.angular_vel = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Command_ID')) {
        this.Command_ID = initObj.Command_ID
      }
      else {
        this.Command_ID = 0;
      }
      if (initObj.hasOwnProperty('Mode')) {
        this.Mode = initObj.Mode
      }
      else {
        this.Mode = 0;
      }
      if (initObj.hasOwnProperty('position_ref')) {
        this.position_ref = initObj.position_ref
      }
      else {
        this.position_ref = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('yaw_ref')) {
        this.yaw_ref = initObj.yaw_ref
      }
      else {
        this.yaw_ref = 0.0;
      }
      if (initObj.hasOwnProperty('linear_vel')) {
        this.linear_vel = initObj.linear_vel
      }
      else {
        this.linear_vel = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('angular_vel')) {
        this.angular_vel = initObj.angular_vel
      }
      else {
        this.angular_vel = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UGVCommand
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [Command_ID]
    bufferOffset = _serializer.uint32(obj.Command_ID, buffer, bufferOffset);
    // Serialize message field [Mode]
    bufferOffset = _serializer.uint8(obj.Mode, buffer, bufferOffset);
    // Check that the constant length array field [position_ref] has the right length
    if (obj.position_ref.length !== 2) {
      throw new Error('Unable to serialize array field position_ref - length must be 2')
    }
    // Serialize message field [position_ref]
    bufferOffset = _arraySerializer.float32(obj.position_ref, buffer, bufferOffset, 2);
    // Serialize message field [yaw_ref]
    bufferOffset = _serializer.float32(obj.yaw_ref, buffer, bufferOffset);
    // Check that the constant length array field [linear_vel] has the right length
    if (obj.linear_vel.length !== 2) {
      throw new Error('Unable to serialize array field linear_vel - length must be 2')
    }
    // Serialize message field [linear_vel]
    bufferOffset = _arraySerializer.float32(obj.linear_vel, buffer, bufferOffset, 2);
    // Serialize message field [angular_vel]
    bufferOffset = _serializer.float32(obj.angular_vel, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UGVCommand
    let len;
    let data = new UGVCommand(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Command_ID]
    data.Command_ID = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [Mode]
    data.Mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [position_ref]
    data.position_ref = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    // Deserialize message field [yaw_ref]
    data.yaw_ref = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [linear_vel]
    data.linear_vel = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    // Deserialize message field [angular_vel]
    data.angular_vel = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 29;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/UGVCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b962762976e3397032e3506cd36fbcbc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
    uint32 Command_ID
    
    ## 控制命令的模式 
    uint8 Mode
    # enum Mode 控制模式枚举
    uint8 Hold=0
    uint8 Direct_Control_BODY=1
    uint8 Direct_Control_ENU=2
    uint8 Point_Control=3
    uint8 Path_Control=4
    uint8 Test=5
    
    float32[2] position_ref     ## [m]
    float32 yaw_ref             ## [rad]
    
    float32[2] linear_vel       ## [m/s]
    float32 angular_vel         ## [rad/s]
    
    
    
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
    const resolved = new UGVCommand(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.Command_ID !== undefined) {
      resolved.Command_ID = msg.Command_ID;
    }
    else {
      resolved.Command_ID = 0
    }

    if (msg.Mode !== undefined) {
      resolved.Mode = msg.Mode;
    }
    else {
      resolved.Mode = 0
    }

    if (msg.position_ref !== undefined) {
      resolved.position_ref = msg.position_ref;
    }
    else {
      resolved.position_ref = new Array(2).fill(0)
    }

    if (msg.yaw_ref !== undefined) {
      resolved.yaw_ref = msg.yaw_ref;
    }
    else {
      resolved.yaw_ref = 0.0
    }

    if (msg.linear_vel !== undefined) {
      resolved.linear_vel = msg.linear_vel;
    }
    else {
      resolved.linear_vel = new Array(2).fill(0)
    }

    if (msg.angular_vel !== undefined) {
      resolved.angular_vel = msg.angular_vel;
    }
    else {
      resolved.angular_vel = 0.0
    }

    return resolved;
    }
};

// Constants for message
UGVCommand.Constants = {
  HOLD: 0,
  DIRECT_CONTROL_BODY: 1,
  DIRECT_CONTROL_ENU: 2,
  POINT_CONTROL: 3,
  PATH_CONTROL: 4,
  TEST: 5,
}

module.exports = UGVCommand;
