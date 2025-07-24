// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let DetectionInfo = require('./DetectionInfo.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MultiDetectionInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.num_objs = null;
      this.detect_or_track = null;
      this.detection_infos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('num_objs')) {
        this.num_objs = initObj.num_objs
      }
      else {
        this.num_objs = 0;
      }
      if (initObj.hasOwnProperty('detect_or_track')) {
        this.detect_or_track = initObj.detect_or_track
      }
      else {
        this.detect_or_track = 0;
      }
      if (initObj.hasOwnProperty('detection_infos')) {
        this.detection_infos = initObj.detection_infos
      }
      else {
        this.detection_infos = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MultiDetectionInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [num_objs]
    bufferOffset = _serializer.int32(obj.num_objs, buffer, bufferOffset);
    // Serialize message field [detect_or_track]
    bufferOffset = _serializer.int32(obj.detect_or_track, buffer, bufferOffset);
    // Serialize message field [detection_infos]
    // Serialize the length for message field [detection_infos]
    bufferOffset = _serializer.uint32(obj.detection_infos.length, buffer, bufferOffset);
    obj.detection_infos.forEach((val) => {
      bufferOffset = DetectionInfo.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MultiDetectionInfo
    let len;
    let data = new MultiDetectionInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [num_objs]
    data.num_objs = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [detect_or_track]
    data.detect_or_track = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [detection_infos]
    // Deserialize array length for message field [detection_infos]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.detection_infos = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.detection_infos[i] = DetectionInfo.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.detection_infos.forEach((val) => {
      length += DetectionInfo.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/MultiDetectionInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '405c23f2d6cf2075daf7e96c3ccd5179';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    ## 检测到的目标数量
    int32 num_objs
    
    ## Detecting or Tracking (0:detect, 1:track)
    int32 detect_or_track
    
    ## 每个目标的检测结果
    DetectionInfo[] detection_infos
    
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
    
    ================================================================================
    MSG: uavcontrol_msgs/DetectionInfo
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MultiDetectionInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.num_objs !== undefined) {
      resolved.num_objs = msg.num_objs;
    }
    else {
      resolved.num_objs = 0
    }

    if (msg.detect_or_track !== undefined) {
      resolved.detect_or_track = msg.detect_or_track;
    }
    else {
      resolved.detect_or_track = 0
    }

    if (msg.detection_infos !== undefined) {
      resolved.detection_infos = new Array(msg.detection_infos.length);
      for (let i = 0; i < resolved.detection_infos.length; ++i) {
        resolved.detection_infos[i] = DetectionInfo.Resolve(msg.detection_infos[i]);
      }
    }
    else {
      resolved.detection_infos = []
    }

    return resolved;
    }
};

module.exports = MultiDetectionInfo;
