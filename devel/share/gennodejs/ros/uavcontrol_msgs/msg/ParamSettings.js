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

class ParamSettings {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.param_name = null;
      this.param_value = null;
    }
    else {
      if (initObj.hasOwnProperty('param_name')) {
        this.param_name = initObj.param_name
      }
      else {
        this.param_name = [];
      }
      if (initObj.hasOwnProperty('param_value')) {
        this.param_value = initObj.param_value
      }
      else {
        this.param_value = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParamSettings
    // Serialize message field [param_name]
    bufferOffset = _arraySerializer.string(obj.param_name, buffer, bufferOffset, null);
    // Serialize message field [param_value]
    bufferOffset = _arraySerializer.string(obj.param_value, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParamSettings
    let len;
    let data = new ParamSettings(null);
    // Deserialize message field [param_name]
    data.param_name = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [param_value]
    data.param_value = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.param_name.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    object.param_value.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/ParamSettings';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '75157f8febd181d39db292f566f5eebb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] param_name
    string[] param_value
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ParamSettings(null);
    if (msg.param_name !== undefined) {
      resolved.param_name = msg.param_name;
    }
    else {
      resolved.param_name = []
    }

    if (msg.param_value !== undefined) {
      resolved.param_value = msg.param_value;
    }
    else {
      resolved.param_value = []
    }

    return resolved;
    }
};

module.exports = ParamSettings;
