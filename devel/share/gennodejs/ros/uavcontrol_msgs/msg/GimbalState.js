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

class GimbalState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.type = null;
      this.moveMode = null;
      this.imageMode = null;
      this.isZoom = null;
      this.isRec = null;
      this.fov = null;
      this.angleRT = null;
      this.angleRTRate = null;
      this.angleRateSet = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = 0;
      }
      if (initObj.hasOwnProperty('moveMode')) {
        this.moveMode = initObj.moveMode
      }
      else {
        this.moveMode = 0;
      }
      if (initObj.hasOwnProperty('imageMode')) {
        this.imageMode = initObj.imageMode
      }
      else {
        this.imageMode = 0;
      }
      if (initObj.hasOwnProperty('isZoom')) {
        this.isZoom = initObj.isZoom
      }
      else {
        this.isZoom = false;
      }
      if (initObj.hasOwnProperty('isRec')) {
        this.isRec = initObj.isRec
      }
      else {
        this.isRec = 0;
      }
      if (initObj.hasOwnProperty('fov')) {
        this.fov = initObj.fov
      }
      else {
        this.fov = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('angleRT')) {
        this.angleRT = initObj.angleRT
      }
      else {
        this.angleRT = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('angleRTRate')) {
        this.angleRTRate = initObj.angleRTRate
      }
      else {
        this.angleRTRate = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('angleRateSet')) {
        this.angleRateSet = initObj.angleRateSet
      }
      else {
        this.angleRateSet = new Array(3).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GimbalState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.uint8(obj.type, buffer, bufferOffset);
    // Serialize message field [moveMode]
    bufferOffset = _serializer.uint8(obj.moveMode, buffer, bufferOffset);
    // Serialize message field [imageMode]
    bufferOffset = _serializer.uint8(obj.imageMode, buffer, bufferOffset);
    // Serialize message field [isZoom]
    bufferOffset = _serializer.bool(obj.isZoom, buffer, bufferOffset);
    // Serialize message field [isRec]
    bufferOffset = _serializer.uint8(obj.isRec, buffer, bufferOffset);
    // Check that the constant length array field [fov] has the right length
    if (obj.fov.length !== 2) {
      throw new Error('Unable to serialize array field fov - length must be 2')
    }
    // Serialize message field [fov]
    bufferOffset = _arraySerializer.float32(obj.fov, buffer, bufferOffset, 2);
    // Check that the constant length array field [angleRT] has the right length
    if (obj.angleRT.length !== 3) {
      throw new Error('Unable to serialize array field angleRT - length must be 3')
    }
    // Serialize message field [angleRT]
    bufferOffset = _arraySerializer.float32(obj.angleRT, buffer, bufferOffset, 3);
    // Check that the constant length array field [angleRTRate] has the right length
    if (obj.angleRTRate.length !== 3) {
      throw new Error('Unable to serialize array field angleRTRate - length must be 3')
    }
    // Serialize message field [angleRTRate]
    bufferOffset = _arraySerializer.float32(obj.angleRTRate, buffer, bufferOffset, 3);
    // Check that the constant length array field [angleRateSet] has the right length
    if (obj.angleRateSet.length !== 3) {
      throw new Error('Unable to serialize array field angleRateSet - length must be 3')
    }
    // Serialize message field [angleRateSet]
    bufferOffset = _arraySerializer.float32(obj.angleRateSet, buffer, bufferOffset, 3);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GimbalState
    let len;
    let data = new GimbalState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [moveMode]
    data.moveMode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [imageMode]
    data.imageMode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [isZoom]
    data.isZoom = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [isRec]
    data.isRec = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [fov]
    data.fov = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    // Deserialize message field [angleRT]
    data.angleRT = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [angleRTRate]
    data.angleRTRate = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [angleRateSet]
    data.angleRateSet = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 49;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/GimbalState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '17d9d9f817a22490d422f0f90e0623a4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # gimbal type; value = {SV::GimbalType};0:G1;1:Q10F;2:AT10;3:GX40;4:SU17
    uint8 type
    # gimbal movement mode; 0:None; 1:lock head; 2：unlock head; 3: tracking;
    uint8 moveMode
    # gimbal image type; 0:normal; 1:infrared; 2:merge;
    uint8 imageMode
    # gimbal zoom
    bool isZoom
    # gimbal rec; 0:none; 1:gimbal rec; 2:local rec; 3:gimbal & local rec;
    uint8 isRec
    # gimbal fov, XY
    float32[2] fov
    # gimbal real time angle, RPY <deg>
    float32[3] angleRT
    # gimbal real time angle rate, RPY <deg/s> <if gimbal supported>
    float32[3] angleRTRate
    # gimbal setted max angle rate <deg/s> <if gimbal supported>
    float32[3] angleRateSet
    
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
    const resolved = new GimbalState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = 0
    }

    if (msg.moveMode !== undefined) {
      resolved.moveMode = msg.moveMode;
    }
    else {
      resolved.moveMode = 0
    }

    if (msg.imageMode !== undefined) {
      resolved.imageMode = msg.imageMode;
    }
    else {
      resolved.imageMode = 0
    }

    if (msg.isZoom !== undefined) {
      resolved.isZoom = msg.isZoom;
    }
    else {
      resolved.isZoom = false
    }

    if (msg.isRec !== undefined) {
      resolved.isRec = msg.isRec;
    }
    else {
      resolved.isRec = 0
    }

    if (msg.fov !== undefined) {
      resolved.fov = msg.fov;
    }
    else {
      resolved.fov = new Array(2).fill(0)
    }

    if (msg.angleRT !== undefined) {
      resolved.angleRT = msg.angleRT;
    }
    else {
      resolved.angleRT = new Array(3).fill(0)
    }

    if (msg.angleRTRate !== undefined) {
      resolved.angleRTRate = msg.angleRTRate;
    }
    else {
      resolved.angleRTRate = new Array(3).fill(0)
    }

    if (msg.angleRateSet !== undefined) {
      resolved.angleRateSet = msg.angleRateSet;
    }
    else {
      resolved.angleRateSet = new Array(3).fill(0)
    }

    return resolved;
    }
};

module.exports = GimbalState;
