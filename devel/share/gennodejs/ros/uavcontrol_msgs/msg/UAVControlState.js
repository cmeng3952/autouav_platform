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

class UAVControlState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.uav_id = null;
      this.control_state = null;
      this.pos_controller = null;
      this.failsafe = null;
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
      if (initObj.hasOwnProperty('control_state')) {
        this.control_state = initObj.control_state
      }
      else {
        this.control_state = 0;
      }
      if (initObj.hasOwnProperty('pos_controller')) {
        this.pos_controller = initObj.pos_controller
      }
      else {
        this.pos_controller = 0;
      }
      if (initObj.hasOwnProperty('failsafe')) {
        this.failsafe = initObj.failsafe
      }
      else {
        this.failsafe = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UAVControlState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [uav_id]
    bufferOffset = _serializer.uint8(obj.uav_id, buffer, bufferOffset);
    // Serialize message field [control_state]
    bufferOffset = _serializer.uint8(obj.control_state, buffer, bufferOffset);
    // Serialize message field [pos_controller]
    bufferOffset = _serializer.uint8(obj.pos_controller, buffer, bufferOffset);
    // Serialize message field [failsafe]
    bufferOffset = _serializer.bool(obj.failsafe, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UAVControlState
    let len;
    let data = new UAVControlState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [uav_id]
    data.uav_id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [control_state]
    data.control_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [pos_controller]
    data.pos_controller = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [failsafe]
    data.failsafe = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/UAVControlState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2f696ea290ca1c1f46b8e82d115caeea';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 无人机编号 
    uint8 uav_id
    
    ## 无人机控制状态
    uint8 control_state
    ## 状态枚举
    uint8 INIT=0
    uint8 RC_POS_CONTROL=1
    uint8 COMMAND_CONTROL=2
    uint8 LAND_CONTROL=3
    
    ## 无人机控制器标志量
    uint8 pos_controller
    ## 状态枚举
    uint8 PX4_ORIGIN=0
    uint8 PID=1
    uint8 UDE=2
    uint8 NE=3
    
    # 无人机安全保护触发标志量
    bool failsafe
    
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
    const resolved = new UAVControlState(null);
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

    if (msg.control_state !== undefined) {
      resolved.control_state = msg.control_state;
    }
    else {
      resolved.control_state = 0
    }

    if (msg.pos_controller !== undefined) {
      resolved.pos_controller = msg.pos_controller;
    }
    else {
      resolved.pos_controller = 0
    }

    if (msg.failsafe !== undefined) {
      resolved.failsafe = msg.failsafe;
    }
    else {
      resolved.failsafe = false
    }

    return resolved;
    }
};

// Constants for message
UAVControlState.Constants = {
  INIT: 0,
  RC_POS_CONTROL: 1,
  COMMAND_CONTROL: 2,
  LAND_CONTROL: 3,
  PX4_ORIGIN: 0,
  PID: 1,
  UDE: 2,
  NE: 3,
}

module.exports = UAVControlState;
