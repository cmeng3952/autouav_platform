// Auto-generated. Do not edit!

// (in-package uavcontrol_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class FormationAssign {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.formation_poses = null;
      this.assigned = null;
    }
    else {
      if (initObj.hasOwnProperty('formation_poses')) {
        this.formation_poses = initObj.formation_poses
      }
      else {
        this.formation_poses = [];
      }
      if (initObj.hasOwnProperty('assigned')) {
        this.assigned = initObj.assigned
      }
      else {
        this.assigned = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FormationAssign
    // Serialize message field [formation_poses]
    // Serialize the length for message field [formation_poses]
    bufferOffset = _serializer.uint32(obj.formation_poses.length, buffer, bufferOffset);
    obj.formation_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [assigned]
    bufferOffset = _arraySerializer.bool(obj.assigned, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FormationAssign
    let len;
    let data = new FormationAssign(null);
    // Deserialize message field [formation_poses]
    // Deserialize array length for message field [formation_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.formation_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.formation_poses[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [assigned]
    data.assigned = _arrayDeserializer.bool(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.formation_poses.length;
    length += object.assigned.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/FormationAssign';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8ecb1c52bd44cfc87c006bf62284d4ef';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #队形位置
    geometry_msgs/Point[] formation_poses
    
    #位置点是否选取
    bool[] assigned
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FormationAssign(null);
    if (msg.formation_poses !== undefined) {
      resolved.formation_poses = new Array(msg.formation_poses.length);
      for (let i = 0; i < resolved.formation_poses.length; ++i) {
        resolved.formation_poses[i] = geometry_msgs.msg.Point.Resolve(msg.formation_poses[i]);
      }
    }
    else {
      resolved.formation_poses = []
    }

    if (msg.assigned !== undefined) {
      resolved.assigned = msg.assigned;
    }
    else {
      resolved.assigned = []
    }

    return resolved;
    }
};

module.exports = FormationAssign;
