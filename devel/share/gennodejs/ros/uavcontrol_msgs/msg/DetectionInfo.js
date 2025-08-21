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

class DetectionInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.object_name = null;
      this.detected = null;
      this.frame = null;
      this.position = null;
      this.attitude = null;
      this.attitude_q = null;
      this.sight_angle = null;
      this.pixel_position = null;
      this.yaw_error = null;
      this.category = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('object_name')) {
        this.object_name = initObj.object_name
      }
      else {
        this.object_name = '';
      }
      if (initObj.hasOwnProperty('detected')) {
        this.detected = initObj.detected
      }
      else {
        this.detected = false;
      }
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = 0;
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('attitude')) {
        this.attitude = initObj.attitude
      }
      else {
        this.attitude = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('attitude_q')) {
        this.attitude_q = initObj.attitude_q
      }
      else {
        this.attitude_q = new Array(4).fill(0);
      }
      if (initObj.hasOwnProperty('sight_angle')) {
        this.sight_angle = initObj.sight_angle
      }
      else {
        this.sight_angle = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('pixel_position')) {
        this.pixel_position = initObj.pixel_position
      }
      else {
        this.pixel_position = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('yaw_error')) {
        this.yaw_error = initObj.yaw_error
      }
      else {
        this.yaw_error = 0.0;
      }
      if (initObj.hasOwnProperty('category')) {
        this.category = initObj.category
      }
      else {
        this.category = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DetectionInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [object_name]
    bufferOffset = _serializer.string(obj.object_name, buffer, bufferOffset);
    // Serialize message field [detected]
    bufferOffset = _serializer.bool(obj.detected, buffer, bufferOffset);
    // Serialize message field [frame]
    bufferOffset = _serializer.int32(obj.frame, buffer, bufferOffset);
    // Check that the constant length array field [position] has the right length
    if (obj.position.length !== 3) {
      throw new Error('Unable to serialize array field position - length must be 3')
    }
    // Serialize message field [position]
    bufferOffset = _arraySerializer.float32(obj.position, buffer, bufferOffset, 3);
    // Check that the constant length array field [attitude] has the right length
    if (obj.attitude.length !== 3) {
      throw new Error('Unable to serialize array field attitude - length must be 3')
    }
    // Serialize message field [attitude]
    bufferOffset = _arraySerializer.float32(obj.attitude, buffer, bufferOffset, 3);
    // Check that the constant length array field [attitude_q] has the right length
    if (obj.attitude_q.length !== 4) {
      throw new Error('Unable to serialize array field attitude_q - length must be 4')
    }
    // Serialize message field [attitude_q]
    bufferOffset = _arraySerializer.float32(obj.attitude_q, buffer, bufferOffset, 4);
    // Check that the constant length array field [sight_angle] has the right length
    if (obj.sight_angle.length !== 2) {
      throw new Error('Unable to serialize array field sight_angle - length must be 2')
    }
    // Serialize message field [sight_angle]
    bufferOffset = _arraySerializer.float32(obj.sight_angle, buffer, bufferOffset, 2);
    // Check that the constant length array field [pixel_position] has the right length
    if (obj.pixel_position.length !== 2) {
      throw new Error('Unable to serialize array field pixel_position - length must be 2')
    }
    // Serialize message field [pixel_position]
    bufferOffset = _arraySerializer.int32(obj.pixel_position, buffer, bufferOffset, 2);
    // Serialize message field [yaw_error]
    bufferOffset = _serializer.float32(obj.yaw_error, buffer, bufferOffset);
    // Serialize message field [category]
    bufferOffset = _serializer.int32(obj.category, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DetectionInfo
    let len;
    let data = new DetectionInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [object_name]
    data.object_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [detected]
    data.detected = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [frame]
    data.frame = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [attitude]
    data.attitude = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [attitude_q]
    data.attitude_q = _arrayDeserializer.float32(buffer, bufferOffset, 4)
    // Deserialize message field [sight_angle]
    data.sight_angle = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    // Deserialize message field [pixel_position]
    data.pixel_position = _arrayDeserializer.int32(buffer, bufferOffset, 2)
    // Deserialize message field [yaw_error]
    data.yaw_error = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [category]
    data.category = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.object_name);
    return length + 73;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/DetectionInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '64a1138d8e77ba66759026fce69b90a9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 目标信息
    
    std_msgs/Header header
    
    ## 目标类别名称
    string object_name
    
    ## 是否检测到目标
    bool detected
    
    ## 0表示相机坐标系, 1表示机体坐标系, 2表示惯性坐标系
    int32 frame
    
    ## 目标位置[相机系下：右方x为正，下方y为正，前方z为正]
    float32[3] position
    
    ## 目标姿态-欧拉角-(z,y,x)
    float32[3] attitude
    
    ## 目标姿态-四元数-(qx,qy,qz,qw)
    float32[4] attitude_q
    
    ## 视线角度[相机系下：右方x角度为正，下方y角度为正]
    float32[2] sight_angle
    
    ## 像素位置[相机系下：右方x为正，下方y为正]
    int32[2] pixel_position
    
    ## 偏航角误差
    float32 yaw_error
    
    ## 类别
    int32 category
    
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
    const resolved = new DetectionInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.object_name !== undefined) {
      resolved.object_name = msg.object_name;
    }
    else {
      resolved.object_name = ''
    }

    if (msg.detected !== undefined) {
      resolved.detected = msg.detected;
    }
    else {
      resolved.detected = false
    }

    if (msg.frame !== undefined) {
      resolved.frame = msg.frame;
    }
    else {
      resolved.frame = 0
    }

    if (msg.position !== undefined) {
      resolved.position = msg.position;
    }
    else {
      resolved.position = new Array(3).fill(0)
    }

    if (msg.attitude !== undefined) {
      resolved.attitude = msg.attitude;
    }
    else {
      resolved.attitude = new Array(3).fill(0)
    }

    if (msg.attitude_q !== undefined) {
      resolved.attitude_q = msg.attitude_q;
    }
    else {
      resolved.attitude_q = new Array(4).fill(0)
    }

    if (msg.sight_angle !== undefined) {
      resolved.sight_angle = msg.sight_angle;
    }
    else {
      resolved.sight_angle = new Array(2).fill(0)
    }

    if (msg.pixel_position !== undefined) {
      resolved.pixel_position = msg.pixel_position;
    }
    else {
      resolved.pixel_position = new Array(2).fill(0)
    }

    if (msg.yaw_error !== undefined) {
      resolved.yaw_error = msg.yaw_error;
    }
    else {
      resolved.yaw_error = 0.0
    }

    if (msg.category !== undefined) {
      resolved.category = msg.category;
    }
    else {
      resolved.category = 0
    }

    return resolved;
    }
};

module.exports = DetectionInfo;
