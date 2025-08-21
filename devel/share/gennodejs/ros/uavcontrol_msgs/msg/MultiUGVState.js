// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let UGVState = require('./UGVState.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MultiUGVState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.swarm_num_ugv = null;
      this.ugv_state_all = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('swarm_num_ugv')) {
        this.swarm_num_ugv = initObj.swarm_num_ugv
      }
      else {
        this.swarm_num_ugv = 0;
      }
      if (initObj.hasOwnProperty('ugv_state_all')) {
        this.ugv_state_all = initObj.ugv_state_all
      }
      else {
        this.ugv_state_all = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MultiUGVState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [swarm_num_ugv]
    bufferOffset = _serializer.int32(obj.swarm_num_ugv, buffer, bufferOffset);
    // Serialize message field [ugv_state_all]
    // Serialize the length for message field [ugv_state_all]
    bufferOffset = _serializer.uint32(obj.ugv_state_all.length, buffer, bufferOffset);
    obj.ugv_state_all.forEach((val) => {
      bufferOffset = UGVState.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MultiUGVState
    let len;
    let data = new MultiUGVState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [swarm_num_ugv]
    data.swarm_num_ugv = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [ugv_state_all]
    // Deserialize array length for message field [ugv_state_all]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.ugv_state_all = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.ugv_state_all[i] = UGVState.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.ugv_state_all.forEach((val) => {
      length += UGVState.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/MultiUGVState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a186972accb0af8d487fa5c5c2db7013';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 
    int32 swarm_num_ugv
    
    ## 从1开始
    UGVState[] ugv_state_all
    
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
    MSG: uavcontrol_msgs/UGVState
    std_msgs/Header header
    
    ## 无人机编号
    uint8 ugv_id
    
    ## 电池电量
    float32 battery
    
    ## 无人机状态量：位置、速度、姿态
    float32[3] position                 ## [m]
    float32[3] velocity                 ## [m/s]
    float32[3] attitude                 ## [rad]
    
    geometry_msgs/Quaternion attitude_q ## 四元数
    
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
    const resolved = new MultiUGVState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.swarm_num_ugv !== undefined) {
      resolved.swarm_num_ugv = msg.swarm_num_ugv;
    }
    else {
      resolved.swarm_num_ugv = 0
    }

    if (msg.ugv_state_all !== undefined) {
      resolved.ugv_state_all = new Array(msg.ugv_state_all.length);
      for (let i = 0; i < resolved.ugv_state_all.length; ++i) {
        resolved.ugv_state_all[i] = UGVState.Resolve(msg.ugv_state_all[i]);
      }
    }
    else {
      resolved.ugv_state_all = []
    }

    return resolved;
    }
};

module.exports = MultiUGVState;
