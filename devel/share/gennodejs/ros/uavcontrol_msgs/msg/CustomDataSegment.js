// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let BasicDataTypeAndValue = require('./BasicDataTypeAndValue.js');

//-----------------------------------------------------------

class CustomDataSegment {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.datas = null;
    }
    else {
      if (initObj.hasOwnProperty('datas')) {
        this.datas = initObj.datas
      }
      else {
        this.datas = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CustomDataSegment
    // Serialize message field [datas]
    // Serialize the length for message field [datas]
    bufferOffset = _serializer.uint32(obj.datas.length, buffer, bufferOffset);
    obj.datas.forEach((val) => {
      bufferOffset = BasicDataTypeAndValue.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CustomDataSegment
    let len;
    let data = new CustomDataSegment(null);
    // Deserialize message field [datas]
    // Deserialize array length for message field [datas]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.datas = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.datas[i] = BasicDataTypeAndValue.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.datas.forEach((val) => {
      length += BasicDataTypeAndValue.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/CustomDataSegment';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2c5eb9fae1fd643ad2bc94816d320d81';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    BasicDataTypeAndValue[] datas
    ================================================================================
    MSG: uavcontrol_msgs/BasicDataTypeAndValue
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
    const resolved = new CustomDataSegment(null);
    if (msg.datas !== undefined) {
      resolved.datas = new Array(msg.datas.length);
      for (let i = 0; i < resolved.datas.length; ++i) {
        resolved.datas[i] = BasicDataTypeAndValue.Resolve(msg.datas[i]);
      }
    }
    else {
      resolved.datas = []
    }

    return resolved;
    }
};

module.exports = CustomDataSegment;
