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

class LedStates {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.is_active = null;
      this.state = null;
    }
    else {
      if (initObj.hasOwnProperty('is_active')) {
        this.is_active = initObj.is_active
      }
      else {
        this.is_active = false;
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LedStates
    // Serialize message field [is_active]
    bufferOffset = _serializer.bool(obj.is_active, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.string(obj.state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LedStates
    let len;
    let data = new LedStates(null);
    // Deserialize message field [is_active]
    data.is_active = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.state);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/LedStates';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1165944cad65c58bd2d119eb4ad9c08c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool is_active  # 喊话开关状态：1开启，0关闭
    string state
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LedStates(null);
    if (msg.is_active !== undefined) {
      resolved.is_active = msg.is_active;
    }
    else {
      resolved.is_active = false
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = ''
    }

    return resolved;
    }
};

module.exports = LedStates;
