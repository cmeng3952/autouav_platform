// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class DetectionInfoSub {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.left = null;
      this.top = null;
      this.bot = null;
      this.right = null;
      this.trackIds = null;
    }
    else {
      if (initObj.hasOwnProperty('left')) {
        this.left = initObj.left
      }
      else {
        this.left = 0.0;
      }
      if (initObj.hasOwnProperty('top')) {
        this.top = initObj.top
      }
      else {
        this.top = 0.0;
      }
      if (initObj.hasOwnProperty('bot')) {
        this.bot = initObj.bot
      }
      else {
        this.bot = 0.0;
      }
      if (initObj.hasOwnProperty('right')) {
        this.right = initObj.right
      }
      else {
        this.right = 0.0;
      }
      if (initObj.hasOwnProperty('trackIds')) {
        this.trackIds = initObj.trackIds
      }
      else {
        this.trackIds = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DetectionInfoSub
    // Serialize message field [left]
    bufferOffset = _serializer.float32(obj.left, buffer, bufferOffset);
    // Serialize message field [top]
    bufferOffset = _serializer.float32(obj.top, buffer, bufferOffset);
    // Serialize message field [bot]
    bufferOffset = _serializer.float32(obj.bot, buffer, bufferOffset);
    // Serialize message field [right]
    bufferOffset = _serializer.float32(obj.right, buffer, bufferOffset);
    // Serialize message field [trackIds]
    bufferOffset = _serializer.int32(obj.trackIds, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DetectionInfoSub
    let len;
    let data = new DetectionInfoSub(null);
    // Deserialize message field [left]
    data.left = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [top]
    data.top = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [bot]
    data.bot = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [right]
    data.right = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [trackIds]
    data.trackIds = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/DetectionInfoSub';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0acdf38ac4afc4c07844dc3ad8b9c432';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #目标框的位置（主要斜对角两个点）
    float32 left
    float32 top
    float32 bot
    float32 right
    
    
    ## TRACK TARGET(目标框ID)
    int32 trackIds
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DetectionInfoSub(null);
    if (msg.left !== undefined) {
      resolved.left = msg.left;
    }
    else {
      resolved.left = 0.0
    }

    if (msg.top !== undefined) {
      resolved.top = msg.top;
    }
    else {
      resolved.top = 0.0
    }

    if (msg.bot !== undefined) {
      resolved.bot = msg.bot;
    }
    else {
      resolved.bot = 0.0
    }

    if (msg.right !== undefined) {
      resolved.right = msg.right;
    }
    else {
      resolved.right = 0.0
    }

    if (msg.trackIds !== undefined) {
      resolved.trackIds = msg.trackIds;
    }
    else {
      resolved.trackIds = 0
    }

    return resolved;
    }
};

module.exports = DetectionInfoSub;
