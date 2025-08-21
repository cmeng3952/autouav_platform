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

class UAVSetup {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.cmd = null;
      this.arming = null;
      this.px4_mode = null;
      this.control_state = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('cmd')) {
        this.cmd = initObj.cmd
      }
      else {
        this.cmd = 0;
      }
      if (initObj.hasOwnProperty('arming')) {
        this.arming = initObj.arming
      }
      else {
        this.arming = false;
      }
      if (initObj.hasOwnProperty('px4_mode')) {
        this.px4_mode = initObj.px4_mode
      }
      else {
        this.px4_mode = '';
      }
      if (initObj.hasOwnProperty('control_state')) {
        this.control_state = initObj.control_state
      }
      else {
        this.control_state = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UAVSetup
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [cmd]
    bufferOffset = _serializer.uint8(obj.cmd, buffer, bufferOffset);
    // Serialize message field [arming]
    bufferOffset = _serializer.bool(obj.arming, buffer, bufferOffset);
    // Serialize message field [px4_mode]
    bufferOffset = _serializer.string(obj.px4_mode, buffer, bufferOffset);
    // Serialize message field [control_state]
    bufferOffset = _serializer.string(obj.control_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UAVSetup
    let len;
    let data = new UAVSetup(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [cmd]
    data.cmd = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [arming]
    data.arming = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [px4_mode]
    data.px4_mode = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [control_state]
    data.control_state = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.px4_mode);
    length += _getByteLength(object.control_state);
    return length + 10;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/UAVSetup';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '393031ce25ae40233f2be809a2db33df';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 无人机Setup类型（可用于模拟遥控器）
    uint8 cmd
    uint8 ARMING = 0
    uint8 SET_PX4_MODE = 1
    uint8 REBOOT_PX4 = 2
    uint8 SET_CONTROL_MODE = 3
    
    bool arming
    
    ## PX4模式名查询:http://wiki.ros.org/mavros/CustomModes
    ## 常用模式名:OFFBOARD,AUTO.LAND,AUTO.RTL,POSCTL
    string px4_mode
    
    ## INIT,MANUAL_CONTROL,HOVER_CONTROL,COMMAND_CONTROL,LAND_CONTROL
    string control_state
    
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
    const resolved = new UAVSetup(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.cmd !== undefined) {
      resolved.cmd = msg.cmd;
    }
    else {
      resolved.cmd = 0
    }

    if (msg.arming !== undefined) {
      resolved.arming = msg.arming;
    }
    else {
      resolved.arming = false
    }

    if (msg.px4_mode !== undefined) {
      resolved.px4_mode = msg.px4_mode;
    }
    else {
      resolved.px4_mode = ''
    }

    if (msg.control_state !== undefined) {
      resolved.control_state = msg.control_state;
    }
    else {
      resolved.control_state = ''
    }

    return resolved;
    }
};

// Constants for message
UAVSetup.Constants = {
  ARMING: 0,
  SET_PX4_MODE: 1,
  REBOOT_PX4: 2,
  SET_CONTROL_MODE: 3,
}

module.exports = UAVSetup;
