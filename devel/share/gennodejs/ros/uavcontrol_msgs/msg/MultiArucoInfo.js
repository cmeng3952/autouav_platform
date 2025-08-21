// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ArucoInfo = require('./ArucoInfo.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MultiArucoInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.num_arucos = null;
      this.aruco_infos = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('num_arucos')) {
        this.num_arucos = initObj.num_arucos
      }
      else {
        this.num_arucos = 0;
      }
      if (initObj.hasOwnProperty('aruco_infos')) {
        this.aruco_infos = initObj.aruco_infos
      }
      else {
        this.aruco_infos = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MultiArucoInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [num_arucos]
    bufferOffset = _serializer.int32(obj.num_arucos, buffer, bufferOffset);
    // Serialize message field [aruco_infos]
    // Serialize the length for message field [aruco_infos]
    bufferOffset = _serializer.uint32(obj.aruco_infos.length, buffer, bufferOffset);
    obj.aruco_infos.forEach((val) => {
      bufferOffset = ArucoInfo.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MultiArucoInfo
    let len;
    let data = new MultiArucoInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [num_arucos]
    data.num_arucos = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [aruco_infos]
    // Deserialize array length for message field [aruco_infos]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.aruco_infos = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.aruco_infos[i] = ArucoInfo.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.aruco_infos.forEach((val) => {
      length += ArucoInfo.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/MultiArucoInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ed01e66cfe7218a97aff05b031ab2f44';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 检测到的aruco码数量
    int32 num_arucos
    
    ## 每个aruco码的检测结果
    ArucoInfo[] aruco_infos
    
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
    MSG: uavcontrol_msgs/ArucoInfo
    std_msgs/Header header
    
    ## aruco编码
    int32 aruco_num
    
    ## 是否检测到目标
    bool detected
    
    ## 目标位置-相机坐标系-(x,y,z)
    ## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正
    float32[3] position
    
    ## 目标姿态-四元数-(qx,qy,qz,qw)
    float32[4] orientation
    
    ## 视线角度-相机系下-(右方x角度为正,下方y角度为正)
    float32[2] sight_angle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MultiArucoInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.num_arucos !== undefined) {
      resolved.num_arucos = msg.num_arucos;
    }
    else {
      resolved.num_arucos = 0
    }

    if (msg.aruco_infos !== undefined) {
      resolved.aruco_infos = new Array(msg.aruco_infos.length);
      for (let i = 0; i < resolved.aruco_infos.length; ++i) {
        resolved.aruco_infos[i] = ArucoInfo.Resolve(msg.aruco_infos[i]);
      }
    }
    else {
      resolved.aruco_infos = []
    }

    return resolved;
    }
};

module.exports = MultiArucoInfo;
