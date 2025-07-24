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

class ArucoInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.aruco_num = null;
      this.detected = null;
      this.position = null;
      this.orientation = null;
      this.sight_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('aruco_num')) {
        this.aruco_num = initObj.aruco_num
      }
      else {
        this.aruco_num = 0;
      }
      if (initObj.hasOwnProperty('detected')) {
        this.detected = initObj.detected
      }
      else {
        this.detected = false;
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = new Array(4).fill(0);
      }
      if (initObj.hasOwnProperty('sight_angle')) {
        this.sight_angle = initObj.sight_angle
      }
      else {
        this.sight_angle = new Array(2).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ArucoInfo
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [aruco_num]
    bufferOffset = _serializer.int32(obj.aruco_num, buffer, bufferOffset);
    // Serialize message field [detected]
    bufferOffset = _serializer.bool(obj.detected, buffer, bufferOffset);
    // Check that the constant length array field [position] has the right length
    if (obj.position.length !== 3) {
      throw new Error('Unable to serialize array field position - length must be 3')
    }
    // Serialize message field [position]
    bufferOffset = _arraySerializer.float32(obj.position, buffer, bufferOffset, 3);
    // Check that the constant length array field [orientation] has the right length
    if (obj.orientation.length !== 4) {
      throw new Error('Unable to serialize array field orientation - length must be 4')
    }
    // Serialize message field [orientation]
    bufferOffset = _arraySerializer.float32(obj.orientation, buffer, bufferOffset, 4);
    // Check that the constant length array field [sight_angle] has the right length
    if (obj.sight_angle.length !== 2) {
      throw new Error('Unable to serialize array field sight_angle - length must be 2')
    }
    // Serialize message field [sight_angle]
    bufferOffset = _arraySerializer.float32(obj.sight_angle, buffer, bufferOffset, 2);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArucoInfo
    let len;
    let data = new ArucoInfo(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [aruco_num]
    data.aruco_num = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [detected]
    data.detected = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [orientation]
    data.orientation = _arrayDeserializer.float32(buffer, bufferOffset, 4)
    // Deserialize message field [sight_angle]
    data.sight_angle = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 41;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/ArucoInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4317d8c5571fc3b7219e3fa681ec1bab';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ArucoInfo(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.aruco_num !== undefined) {
      resolved.aruco_num = msg.aruco_num;
    }
    else {
      resolved.aruco_num = 0
    }

    if (msg.detected !== undefined) {
      resolved.detected = msg.detected;
    }
    else {
      resolved.detected = false
    }

    if (msg.position !== undefined) {
      resolved.position = msg.position;
    }
    else {
      resolved.position = new Array(3).fill(0)
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = msg.orientation;
    }
    else {
      resolved.orientation = new Array(4).fill(0)
    }

    if (msg.sight_angle !== undefined) {
      resolved.sight_angle = msg.sight_angle;
    }
    else {
      resolved.sight_angle = new Array(2).fill(0)
    }

    return resolved;
    }
};

module.exports = ArucoInfo;
