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

class BasicDataTypeAndValue {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.type = null;
      this.integer_value = null;
      this.boolean_value = null;
      this.float_value = null;
      this.double_value = null;
      this.string_value = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('integer_value')) {
        this.integer_value = initObj.integer_value
      }
      else {
        this.integer_value = 0;
      }
      if (initObj.hasOwnProperty('boolean_value')) {
        this.boolean_value = initObj.boolean_value
      }
      else {
        this.boolean_value = false;
      }
      if (initObj.hasOwnProperty('float_value')) {
        this.float_value = initObj.float_value
      }
      else {
        this.float_value = 0.0;
      }
      if (initObj.hasOwnProperty('double_value')) {
        this.double_value = initObj.double_value
      }
      else {
        this.double_value = 0.0;
      }
      if (initObj.hasOwnProperty('string_value')) {
        this.string_value = initObj.string_value
      }
      else {
        this.string_value = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BasicDataTypeAndValue
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint8(obj.type, buffer, bufferOffset);
    // Serialize message field [integer_value]
    bufferOffset = _serializer.int32(obj.integer_value, buffer, bufferOffset);
    // Serialize message field [boolean_value]
    bufferOffset = _serializer.bool(obj.boolean_value, buffer, bufferOffset);
    // Serialize message field [float_value]
    bufferOffset = _serializer.float32(obj.float_value, buffer, bufferOffset);
    // Serialize message field [double_value]
    bufferOffset = _serializer.float64(obj.double_value, buffer, bufferOffset);
    // Serialize message field [string_value]
    bufferOffset = _serializer.string(obj.string_value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BasicDataTypeAndValue
    let len;
    let data = new BasicDataTypeAndValue(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [integer_value]
    data.integer_value = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [boolean_value]
    data.boolean_value = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [float_value]
    data.float_value = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [double_value]
    data.double_value = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [string_value]
    data.string_value = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    length += _getByteLength(object.string_value);
    return length + 26;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/BasicDataTypeAndValue';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '43928e1d51d365ceca1cc00365d754f1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    
    uint8 type
    uint8 INTEGER=1
    uint8 BOOLEAN=2
    uint8 FLOAT=3
    uint8 DOUBLE=4
    uint8 STRING=5
    
    int32 integer_value
    bool boolean_value
    float32 float_value
    float64 double_value
    string string_value
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BasicDataTypeAndValue(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.integer_value !== undefined) {
      resolved.integer_value = msg.integer_value;
    }
    else {
      resolved.integer_value = 0
    }

    if (msg.boolean_value !== undefined) {
      resolved.boolean_value = msg.boolean_value;
    }
    else {
      resolved.boolean_value = false
    }

    if (msg.float_value !== undefined) {
      resolved.float_value = msg.float_value;
    }
    else {
      resolved.float_value = 0.0
    }

    if (msg.double_value !== undefined) {
      resolved.double_value = msg.double_value;
    }
    else {
      resolved.double_value = 0.0
    }

    if (msg.string_value !== undefined) {
      resolved.string_value = msg.string_value;
    }
    else {
      resolved.string_value = ''
    }

    return resolved;
    }
};

// Constants for message
BasicDataTypeAndValue.Constants = {
  INTEGER: 1,
  BOOLEAN: 2,
  FLOAT: 3,
  DOUBLE: 4,
  STRING: 5,
}

module.exports = BasicDataTypeAndValue;
