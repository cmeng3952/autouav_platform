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

class GlobalAruco {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.Aruco1 = null;
      this.Aruco2 = null;
      this.Aruco3 = null;
      this.Aruco4 = null;
      this.Aruco5 = null;
      this.Aruco6 = null;
      this.Aruco7 = null;
      this.Aruco8 = null;
      this.Aruco9 = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('Aruco1')) {
        this.Aruco1 = initObj.Aruco1
      }
      else {
        this.Aruco1 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco2')) {
        this.Aruco2 = initObj.Aruco2
      }
      else {
        this.Aruco2 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco3')) {
        this.Aruco3 = initObj.Aruco3
      }
      else {
        this.Aruco3 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco4')) {
        this.Aruco4 = initObj.Aruco4
      }
      else {
        this.Aruco4 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco5')) {
        this.Aruco5 = initObj.Aruco5
      }
      else {
        this.Aruco5 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco6')) {
        this.Aruco6 = initObj.Aruco6
      }
      else {
        this.Aruco6 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco7')) {
        this.Aruco7 = initObj.Aruco7
      }
      else {
        this.Aruco7 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco8')) {
        this.Aruco8 = initObj.Aruco8
      }
      else {
        this.Aruco8 = new ArucoInfo();
      }
      if (initObj.hasOwnProperty('Aruco9')) {
        this.Aruco9 = initObj.Aruco9
      }
      else {
        this.Aruco9 = new ArucoInfo();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GlobalAruco
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [Aruco1]
    bufferOffset = ArucoInfo.serialize(obj.Aruco1, buffer, bufferOffset);
    // Serialize message field [Aruco2]
    bufferOffset = ArucoInfo.serialize(obj.Aruco2, buffer, bufferOffset);
    // Serialize message field [Aruco3]
    bufferOffset = ArucoInfo.serialize(obj.Aruco3, buffer, bufferOffset);
    // Serialize message field [Aruco4]
    bufferOffset = ArucoInfo.serialize(obj.Aruco4, buffer, bufferOffset);
    // Serialize message field [Aruco5]
    bufferOffset = ArucoInfo.serialize(obj.Aruco5, buffer, bufferOffset);
    // Serialize message field [Aruco6]
    bufferOffset = ArucoInfo.serialize(obj.Aruco6, buffer, bufferOffset);
    // Serialize message field [Aruco7]
    bufferOffset = ArucoInfo.serialize(obj.Aruco7, buffer, bufferOffset);
    // Serialize message field [Aruco8]
    bufferOffset = ArucoInfo.serialize(obj.Aruco8, buffer, bufferOffset);
    // Serialize message field [Aruco9]
    bufferOffset = ArucoInfo.serialize(obj.Aruco9, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GlobalAruco
    let len;
    let data = new GlobalAruco(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco1]
    data.Aruco1 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco2]
    data.Aruco2 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco3]
    data.Aruco3 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco4]
    data.Aruco4 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco5]
    data.Aruco5 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco6]
    data.Aruco6 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco7]
    data.Aruco7 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco8]
    data.Aruco8 = ArucoInfo.deserialize(buffer, bufferOffset);
    // Deserialize message field [Aruco9]
    data.Aruco9 = ArucoInfo.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += ArucoInfo.getMessageSize(object.Aruco1);
    length += ArucoInfo.getMessageSize(object.Aruco2);
    length += ArucoInfo.getMessageSize(object.Aruco3);
    length += ArucoInfo.getMessageSize(object.Aruco4);
    length += ArucoInfo.getMessageSize(object.Aruco5);
    length += ArucoInfo.getMessageSize(object.Aruco6);
    length += ArucoInfo.getMessageSize(object.Aruco7);
    length += ArucoInfo.getMessageSize(object.Aruco8);
    length += ArucoInfo.getMessageSize(object.Aruco9);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/GlobalAruco';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1ac5e7f2e18092c8685802c04fdbf69a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    std_msgs/Header header
    
    ArucoInfo Aruco1
    ArucoInfo Aruco2
    ArucoInfo Aruco3
    ArucoInfo Aruco4
    ArucoInfo Aruco5
    ArucoInfo Aruco6
    ArucoInfo Aruco7
    ArucoInfo Aruco8
    ArucoInfo Aruco9
    
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
    const resolved = new GlobalAruco(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.Aruco1 !== undefined) {
      resolved.Aruco1 = ArucoInfo.Resolve(msg.Aruco1)
    }
    else {
      resolved.Aruco1 = new ArucoInfo()
    }

    if (msg.Aruco2 !== undefined) {
      resolved.Aruco2 = ArucoInfo.Resolve(msg.Aruco2)
    }
    else {
      resolved.Aruco2 = new ArucoInfo()
    }

    if (msg.Aruco3 !== undefined) {
      resolved.Aruco3 = ArucoInfo.Resolve(msg.Aruco3)
    }
    else {
      resolved.Aruco3 = new ArucoInfo()
    }

    if (msg.Aruco4 !== undefined) {
      resolved.Aruco4 = ArucoInfo.Resolve(msg.Aruco4)
    }
    else {
      resolved.Aruco4 = new ArucoInfo()
    }

    if (msg.Aruco5 !== undefined) {
      resolved.Aruco5 = ArucoInfo.Resolve(msg.Aruco5)
    }
    else {
      resolved.Aruco5 = new ArucoInfo()
    }

    if (msg.Aruco6 !== undefined) {
      resolved.Aruco6 = ArucoInfo.Resolve(msg.Aruco6)
    }
    else {
      resolved.Aruco6 = new ArucoInfo()
    }

    if (msg.Aruco7 !== undefined) {
      resolved.Aruco7 = ArucoInfo.Resolve(msg.Aruco7)
    }
    else {
      resolved.Aruco7 = new ArucoInfo()
    }

    if (msg.Aruco8 !== undefined) {
      resolved.Aruco8 = ArucoInfo.Resolve(msg.Aruco8)
    }
    else {
      resolved.Aruco8 = new ArucoInfo()
    }

    if (msg.Aruco9 !== undefined) {
      resolved.Aruco9 = ArucoInfo.Resolve(msg.Aruco9)
    }
    else {
      resolved.Aruco9 = new ArucoInfo()
    }

    return resolved;
    }
};

module.exports = GlobalAruco;
