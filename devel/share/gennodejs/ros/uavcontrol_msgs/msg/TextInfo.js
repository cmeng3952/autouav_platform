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

class TextInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.MessageType = null;
      this.Message = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('MessageType')) {
        this.MessageType = initObj.MessageType
      }
      else {
        this.MessageType = 0;
      }
      if (initObj.hasOwnProperty('Message')) {
        this.Message = initObj.Message
      }
      else {
        this.Message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TextInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [MessageType]
    bufferOffset = _serializer.uint8(obj.MessageType, buffer, bufferOffset);
    // Serialize message field [Message]
    bufferOffset = _serializer.string(obj.Message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TextInfo
    let len;
    let data = new TextInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [MessageType]
    data.MessageType = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Message]
    data.Message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.Message);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/TextInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1c060392f27880babe5cdc68bd502409';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #INFO:正常运行状况下反馈给地面站的信息,例如程序正常启动,状态切换的提示信息等.
    uint8 INFO=0
    #WARN:无人机或软件程序出现意外情况,依然能正常启动或继续执行任务,小概率会出现危险状况,例如无人机RTK无法维持退出到GPS,视觉跟踪目标突然丢失重新搜寻目标等.
    uint8 WARN=1
    #ERROR:无人机或软件程序出现重大意外情况,无法正常启动或继续执行任务,极有可能会出现危险状况,需要中断任务以及人为接管控制无人机,例如通信中断,无人机定位发散,ROS节点无法正常启动等.
    uint8 ERROR=2
    #FATAL:任务执行过程中,软件崩溃或无人机飞控崩溃导致无人机完全失控,需要迅速人为接管控制无人机降落减少炸机损失.
    uint8 FATAL=3
    
    std_msgs/Header header
    uint8 MessageType
    string Message
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
    const resolved = new TextInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.MessageType !== undefined) {
      resolved.MessageType = msg.MessageType;
    }
    else {
      resolved.MessageType = 0
    }

    if (msg.Message !== undefined) {
      resolved.Message = msg.Message;
    }
    else {
      resolved.Message = ''
    }

    return resolved;
    }
};

// Constants for message
TextInfo.Constants = {
  INFO: 0,
  WARN: 1,
  ERROR: 2,
  FATAL: 3,
}

module.exports = TextInfo;
