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

class VisionDiff {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Id = null;
      this.detect = null;
      this.objectX = null;
      this.objectY = null;
      this.objectWidth = null;
      this.objectHeight = null;
      this.frameWidth = null;
      this.frameHeight = null;
      this.kp = null;
      this.ki = null;
      this.kd = null;
      this.ctlMode = null;
      this.currSize = null;
      this.maxSize = null;
      this.minSize = null;
      this.trackIgnoreError = null;
      this.autoZoom = null;
    }
    else {
      if (initObj.hasOwnProperty('Id')) {
        this.Id = initObj.Id
      }
      else {
        this.Id = 0;
      }
      if (initObj.hasOwnProperty('detect')) {
        this.detect = initObj.detect
      }
      else {
        this.detect = 0;
      }
      if (initObj.hasOwnProperty('objectX')) {
        this.objectX = initObj.objectX
      }
      else {
        this.objectX = 0;
      }
      if (initObj.hasOwnProperty('objectY')) {
        this.objectY = initObj.objectY
      }
      else {
        this.objectY = 0;
      }
      if (initObj.hasOwnProperty('objectWidth')) {
        this.objectWidth = initObj.objectWidth
      }
      else {
        this.objectWidth = 0;
      }
      if (initObj.hasOwnProperty('objectHeight')) {
        this.objectHeight = initObj.objectHeight
      }
      else {
        this.objectHeight = 0;
      }
      if (initObj.hasOwnProperty('frameWidth')) {
        this.frameWidth = initObj.frameWidth
      }
      else {
        this.frameWidth = 0;
      }
      if (initObj.hasOwnProperty('frameHeight')) {
        this.frameHeight = initObj.frameHeight
      }
      else {
        this.frameHeight = 0;
      }
      if (initObj.hasOwnProperty('kp')) {
        this.kp = initObj.kp
      }
      else {
        this.kp = 0.0;
      }
      if (initObj.hasOwnProperty('ki')) {
        this.ki = initObj.ki
      }
      else {
        this.ki = 0.0;
      }
      if (initObj.hasOwnProperty('kd')) {
        this.kd = initObj.kd
      }
      else {
        this.kd = 0.0;
      }
      if (initObj.hasOwnProperty('ctlMode')) {
        this.ctlMode = initObj.ctlMode
      }
      else {
        this.ctlMode = 0;
      }
      if (initObj.hasOwnProperty('currSize')) {
        this.currSize = initObj.currSize
      }
      else {
        this.currSize = 0.0;
      }
      if (initObj.hasOwnProperty('maxSize')) {
        this.maxSize = initObj.maxSize
      }
      else {
        this.maxSize = 0.0;
      }
      if (initObj.hasOwnProperty('minSize')) {
        this.minSize = initObj.minSize
      }
      else {
        this.minSize = 0.0;
      }
      if (initObj.hasOwnProperty('trackIgnoreError')) {
        this.trackIgnoreError = initObj.trackIgnoreError
      }
      else {
        this.trackIgnoreError = 0.0;
      }
      if (initObj.hasOwnProperty('autoZoom')) {
        this.autoZoom = initObj.autoZoom
      }
      else {
        this.autoZoom = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VisionDiff
    // Serialize message field [Id]
    bufferOffset = _serializer.uint8(obj.Id, buffer, bufferOffset);
    // Serialize message field [detect]
    bufferOffset = _serializer.uint8(obj.detect, buffer, bufferOffset);
    // Serialize message field [objectX]
    bufferOffset = _serializer.uint16(obj.objectX, buffer, bufferOffset);
    // Serialize message field [objectY]
    bufferOffset = _serializer.uint16(obj.objectY, buffer, bufferOffset);
    // Serialize message field [objectWidth]
    bufferOffset = _serializer.uint16(obj.objectWidth, buffer, bufferOffset);
    // Serialize message field [objectHeight]
    bufferOffset = _serializer.uint16(obj.objectHeight, buffer, bufferOffset);
    // Serialize message field [frameWidth]
    bufferOffset = _serializer.uint16(obj.frameWidth, buffer, bufferOffset);
    // Serialize message field [frameHeight]
    bufferOffset = _serializer.uint16(obj.frameHeight, buffer, bufferOffset);
    // Serialize message field [kp]
    bufferOffset = _serializer.float32(obj.kp, buffer, bufferOffset);
    // Serialize message field [ki]
    bufferOffset = _serializer.float32(obj.ki, buffer, bufferOffset);
    // Serialize message field [kd]
    bufferOffset = _serializer.float32(obj.kd, buffer, bufferOffset);
    // Serialize message field [ctlMode]
    bufferOffset = _serializer.int8(obj.ctlMode, buffer, bufferOffset);
    // Serialize message field [currSize]
    bufferOffset = _serializer.float32(obj.currSize, buffer, bufferOffset);
    // Serialize message field [maxSize]
    bufferOffset = _serializer.float32(obj.maxSize, buffer, bufferOffset);
    // Serialize message field [minSize]
    bufferOffset = _serializer.float32(obj.minSize, buffer, bufferOffset);
    // Serialize message field [trackIgnoreError]
    bufferOffset = _serializer.float32(obj.trackIgnoreError, buffer, bufferOffset);
    // Serialize message field [autoZoom]
    bufferOffset = _serializer.bool(obj.autoZoom, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VisionDiff
    let len;
    let data = new VisionDiff(null);
    // Deserialize message field [Id]
    data.Id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [detect]
    data.detect = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [objectX]
    data.objectX = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [objectY]
    data.objectY = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [objectWidth]
    data.objectWidth = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [objectHeight]
    data.objectHeight = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [frameWidth]
    data.frameWidth = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [frameHeight]
    data.frameHeight = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [kp]
    data.kp = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ki]
    data.ki = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [kd]
    data.kd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ctlMode]
    data.ctlMode = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [currSize]
    data.currSize = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [maxSize]
    data.maxSize = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [minSize]
    data.minSize = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [trackIgnoreError]
    data.trackIgnoreError = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [autoZoom]
    data.autoZoom = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 44;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/VisionDiff';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '42ea811a55788f015447302191910a5c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 Id
    uint8 detect
    
    uint16 objectX # 左上角
    uint16 objectY # 左上角
    uint16 objectWidth
    uint16 objectHeight
    
    uint16 frameWidth
    uint16 frameHeight
    
    # Gimbal 跟踪pid
    float32 kp
    float32 ki
    float32 kd
    
    int8 ctlMode # 0: yaw+pitch, 1: roll+pitch 3:混合(未实现)
    int8 yawPitch = 0
    int8 rollPitch = 1
    int8 mix=3
    
    # 用于自动缩放
    float32 currSize    #框选近大远小
    float32 maxSize
    float32 minSize #框选大小
    
    float32 trackIgnoreError
    bool autoZoom
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new VisionDiff(null);
    if (msg.Id !== undefined) {
      resolved.Id = msg.Id;
    }
    else {
      resolved.Id = 0
    }

    if (msg.detect !== undefined) {
      resolved.detect = msg.detect;
    }
    else {
      resolved.detect = 0
    }

    if (msg.objectX !== undefined) {
      resolved.objectX = msg.objectX;
    }
    else {
      resolved.objectX = 0
    }

    if (msg.objectY !== undefined) {
      resolved.objectY = msg.objectY;
    }
    else {
      resolved.objectY = 0
    }

    if (msg.objectWidth !== undefined) {
      resolved.objectWidth = msg.objectWidth;
    }
    else {
      resolved.objectWidth = 0
    }

    if (msg.objectHeight !== undefined) {
      resolved.objectHeight = msg.objectHeight;
    }
    else {
      resolved.objectHeight = 0
    }

    if (msg.frameWidth !== undefined) {
      resolved.frameWidth = msg.frameWidth;
    }
    else {
      resolved.frameWidth = 0
    }

    if (msg.frameHeight !== undefined) {
      resolved.frameHeight = msg.frameHeight;
    }
    else {
      resolved.frameHeight = 0
    }

    if (msg.kp !== undefined) {
      resolved.kp = msg.kp;
    }
    else {
      resolved.kp = 0.0
    }

    if (msg.ki !== undefined) {
      resolved.ki = msg.ki;
    }
    else {
      resolved.ki = 0.0
    }

    if (msg.kd !== undefined) {
      resolved.kd = msg.kd;
    }
    else {
      resolved.kd = 0.0
    }

    if (msg.ctlMode !== undefined) {
      resolved.ctlMode = msg.ctlMode;
    }
    else {
      resolved.ctlMode = 0
    }

    if (msg.currSize !== undefined) {
      resolved.currSize = msg.currSize;
    }
    else {
      resolved.currSize = 0.0
    }

    if (msg.maxSize !== undefined) {
      resolved.maxSize = msg.maxSize;
    }
    else {
      resolved.maxSize = 0.0
    }

    if (msg.minSize !== undefined) {
      resolved.minSize = msg.minSize;
    }
    else {
      resolved.minSize = 0.0
    }

    if (msg.trackIgnoreError !== undefined) {
      resolved.trackIgnoreError = msg.trackIgnoreError;
    }
    else {
      resolved.trackIgnoreError = 0.0
    }

    if (msg.autoZoom !== undefined) {
      resolved.autoZoom = msg.autoZoom;
    }
    else {
      resolved.autoZoom = false
    }

    return resolved;
    }
};

// Constants for message
VisionDiff.Constants = {
  YAWPITCH: 0,
  ROLLPITCH: 1,
  MIX: 3,
}

module.exports = VisionDiff;
