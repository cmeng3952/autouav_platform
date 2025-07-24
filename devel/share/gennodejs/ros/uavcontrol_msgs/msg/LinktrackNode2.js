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

class LinktrackNode2 {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.role = null;
      this.id = null;
      this.dis = null;
      this.fp_rssi = null;
      this.rx_rssi = null;
    }
    else {
      if (initObj.hasOwnProperty('role')) {
        this.role = initObj.role
      }
      else {
        this.role = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('dis')) {
        this.dis = initObj.dis
      }
      else {
        this.dis = 0.0;
      }
      if (initObj.hasOwnProperty('fp_rssi')) {
        this.fp_rssi = initObj.fp_rssi
      }
      else {
        this.fp_rssi = 0.0;
      }
      if (initObj.hasOwnProperty('rx_rssi')) {
        this.rx_rssi = initObj.rx_rssi
      }
      else {
        this.rx_rssi = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LinktrackNode2
    // Serialize message field [role]
    bufferOffset = _serializer.uint8(obj.role, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.uint8(obj.id, buffer, bufferOffset);
    // Serialize message field [dis]
    bufferOffset = _serializer.float32(obj.dis, buffer, bufferOffset);
    // Serialize message field [fp_rssi]
    bufferOffset = _serializer.float32(obj.fp_rssi, buffer, bufferOffset);
    // Serialize message field [rx_rssi]
    bufferOffset = _serializer.float32(obj.rx_rssi, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LinktrackNode2
    let len;
    let data = new LinktrackNode2(null);
    // Deserialize message field [role]
    data.role = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dis]
    data.dis = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fp_rssi]
    data.fp_rssi = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rx_rssi]
    data.rx_rssi = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/LinktrackNode2';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ebc34feb8e11fb1b06d65ee49880b996';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 role
    uint8 id
    float32 dis
    float32 fp_rssi
    float32 rx_rssi
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LinktrackNode2(null);
    if (msg.role !== undefined) {
      resolved.role = msg.role;
    }
    else {
      resolved.role = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.dis !== undefined) {
      resolved.dis = msg.dis;
    }
    else {
      resolved.dis = 0.0
    }

    if (msg.fp_rssi !== undefined) {
      resolved.fp_rssi = msg.fp_rssi;
    }
    else {
      resolved.fp_rssi = 0.0
    }

    if (msg.rx_rssi !== undefined) {
      resolved.rx_rssi = msg.rx_rssi;
    }
    else {
      resolved.rx_rssi = 0.0
    }

    return resolved;
    }
};

module.exports = LinktrackNode2;
