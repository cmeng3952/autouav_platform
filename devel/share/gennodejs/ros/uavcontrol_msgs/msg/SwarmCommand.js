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
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class SwarmCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.source = null;
      this.swarm_num = null;
      this.swarm_location_source = null;
      this.Swarm_CMD = null;
      this.leader_pos = null;
      this.leader_vel = null;
      this.swarm_size = null;
      this.swarm_shape = null;
      this.target_area_x_min = null;
      this.target_area_y_min = null;
      this.target_area_x_max = null;
      this.target_area_y_max = null;
      this.attack_target_pos = null;
      this.formation_poses = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = '';
      }
      if (initObj.hasOwnProperty('swarm_num')) {
        this.swarm_num = initObj.swarm_num
      }
      else {
        this.swarm_num = 0;
      }
      if (initObj.hasOwnProperty('swarm_location_source')) {
        this.swarm_location_source = initObj.swarm_location_source
      }
      else {
        this.swarm_location_source = 0;
      }
      if (initObj.hasOwnProperty('Swarm_CMD')) {
        this.Swarm_CMD = initObj.Swarm_CMD
      }
      else {
        this.Swarm_CMD = 0;
      }
      if (initObj.hasOwnProperty('leader_pos')) {
        this.leader_pos = initObj.leader_pos
      }
      else {
        this.leader_pos = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('leader_vel')) {
        this.leader_vel = initObj.leader_vel
      }
      else {
        this.leader_vel = new Array(2).fill(0);
      }
      if (initObj.hasOwnProperty('swarm_size')) {
        this.swarm_size = initObj.swarm_size
      }
      else {
        this.swarm_size = 0.0;
      }
      if (initObj.hasOwnProperty('swarm_shape')) {
        this.swarm_shape = initObj.swarm_shape
      }
      else {
        this.swarm_shape = 0;
      }
      if (initObj.hasOwnProperty('target_area_x_min')) {
        this.target_area_x_min = initObj.target_area_x_min
      }
      else {
        this.target_area_x_min = 0.0;
      }
      if (initObj.hasOwnProperty('target_area_y_min')) {
        this.target_area_y_min = initObj.target_area_y_min
      }
      else {
        this.target_area_y_min = 0.0;
      }
      if (initObj.hasOwnProperty('target_area_x_max')) {
        this.target_area_x_max = initObj.target_area_x_max
      }
      else {
        this.target_area_x_max = 0.0;
      }
      if (initObj.hasOwnProperty('target_area_y_max')) {
        this.target_area_y_max = initObj.target_area_y_max
      }
      else {
        this.target_area_y_max = 0.0;
      }
      if (initObj.hasOwnProperty('attack_target_pos')) {
        this.attack_target_pos = initObj.attack_target_pos
      }
      else {
        this.attack_target_pos = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('formation_poses')) {
        this.formation_poses = initObj.formation_poses
      }
      else {
        this.formation_poses = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SwarmCommand
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.string(obj.source, buffer, bufferOffset);
    // Serialize message field [swarm_num]
    bufferOffset = _serializer.uint8(obj.swarm_num, buffer, bufferOffset);
    // Serialize message field [swarm_location_source]
    bufferOffset = _serializer.uint8(obj.swarm_location_source, buffer, bufferOffset);
    // Serialize message field [Swarm_CMD]
    bufferOffset = _serializer.uint8(obj.Swarm_CMD, buffer, bufferOffset);
    // Check that the constant length array field [leader_pos] has the right length
    if (obj.leader_pos.length !== 3) {
      throw new Error('Unable to serialize array field leader_pos - length must be 3')
    }
    // Serialize message field [leader_pos]
    bufferOffset = _arraySerializer.float32(obj.leader_pos, buffer, bufferOffset, 3);
    // Check that the constant length array field [leader_vel] has the right length
    if (obj.leader_vel.length !== 2) {
      throw new Error('Unable to serialize array field leader_vel - length must be 2')
    }
    // Serialize message field [leader_vel]
    bufferOffset = _arraySerializer.float32(obj.leader_vel, buffer, bufferOffset, 2);
    // Serialize message field [swarm_size]
    bufferOffset = _serializer.float32(obj.swarm_size, buffer, bufferOffset);
    // Serialize message field [swarm_shape]
    bufferOffset = _serializer.uint8(obj.swarm_shape, buffer, bufferOffset);
    // Serialize message field [target_area_x_min]
    bufferOffset = _serializer.float32(obj.target_area_x_min, buffer, bufferOffset);
    // Serialize message field [target_area_y_min]
    bufferOffset = _serializer.float32(obj.target_area_y_min, buffer, bufferOffset);
    // Serialize message field [target_area_x_max]
    bufferOffset = _serializer.float32(obj.target_area_x_max, buffer, bufferOffset);
    // Serialize message field [target_area_y_max]
    bufferOffset = _serializer.float32(obj.target_area_y_max, buffer, bufferOffset);
    // Check that the constant length array field [attack_target_pos] has the right length
    if (obj.attack_target_pos.length !== 3) {
      throw new Error('Unable to serialize array field attack_target_pos - length must be 3')
    }
    // Serialize message field [attack_target_pos]
    bufferOffset = _arraySerializer.float32(obj.attack_target_pos, buffer, bufferOffset, 3);
    // Serialize message field [formation_poses]
    // Serialize the length for message field [formation_poses]
    bufferOffset = _serializer.uint32(obj.formation_poses.length, buffer, bufferOffset);
    obj.formation_poses.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SwarmCommand
    let len;
    let data = new SwarmCommand(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [swarm_num]
    data.swarm_num = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [swarm_location_source]
    data.swarm_location_source = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Swarm_CMD]
    data.Swarm_CMD = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [leader_pos]
    data.leader_pos = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [leader_vel]
    data.leader_vel = _arrayDeserializer.float32(buffer, bufferOffset, 2)
    // Deserialize message field [swarm_size]
    data.swarm_size = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [swarm_shape]
    data.swarm_shape = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [target_area_x_min]
    data.target_area_x_min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [target_area_y_min]
    data.target_area_y_min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [target_area_x_max]
    data.target_area_x_max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [target_area_y_max]
    data.target_area_y_max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [attack_target_pos]
    data.attack_target_pos = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [formation_poses]
    // Deserialize array length for message field [formation_poses]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.formation_poses = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.formation_poses[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.source);
    length += 24 * object.formation_poses.length;
    return length + 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uavcontrol_msgs/SwarmCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '280b61bf48e98d617871f1d573cf0c08';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    ## 消息来源
    string source
    
    ## 编队套件数量
    uint8 swarm_num
    
    uint8 swarm_location_source
    
    # enum loc 定位来源枚举
    uint8 mocap = 0
    uint8 gps = 4
    uint8 rtk = 5
    uint8 uwb = 6
    
    ## 命令
    uint8 Swarm_CMD
    # enum CMD 控制模式枚举
    uint8 Ready=0
    uint8 Init=1
    uint8 Start=2
    uint8 Hold=3
    uint8 Stop=4
    uint8 Formation=5
    
    uint8 Col_Around_Circle=6
    uint8 Col_Follow_UAV=7
    uint8 Col_Follow_UGV=8
    
    uint8 InitPlanner=9
    uint8 SwarmFormationPlanner=10
    
    uint8 Follow=11
    uint8 Search=12
    uint8 Attack=13
    
    ## 编队控制参考量 
    float32[3] leader_pos
    float32[2] leader_vel
    float32 swarm_size
    uint8 swarm_shape
    uint8 One_column=0
    uint8 Triangle=1
    uint8 Square=2
    uint8 Circular=3
    uint8 around_Circle=4
    
    ## 搜索控制参考量 
    float32 target_area_x_min          ## [m]
    float32 target_area_y_min          ## [m]
    float32 target_area_x_max          ## [m]
    float32 target_area_y_max          ## [m]
    
    ## 攻击控制参考量 
    float32[3] attack_target_pos          ## [m]
    
    #队形位置
    geometry_msgs/Point[] formation_poses
    
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
    const resolved = new SwarmCommand(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = ''
    }

    if (msg.swarm_num !== undefined) {
      resolved.swarm_num = msg.swarm_num;
    }
    else {
      resolved.swarm_num = 0
    }

    if (msg.swarm_location_source !== undefined) {
      resolved.swarm_location_source = msg.swarm_location_source;
    }
    else {
      resolved.swarm_location_source = 0
    }

    if (msg.Swarm_CMD !== undefined) {
      resolved.Swarm_CMD = msg.Swarm_CMD;
    }
    else {
      resolved.Swarm_CMD = 0
    }

    if (msg.leader_pos !== undefined) {
      resolved.leader_pos = msg.leader_pos;
    }
    else {
      resolved.leader_pos = new Array(3).fill(0)
    }

    if (msg.leader_vel !== undefined) {
      resolved.leader_vel = msg.leader_vel;
    }
    else {
      resolved.leader_vel = new Array(2).fill(0)
    }

    if (msg.swarm_size !== undefined) {
      resolved.swarm_size = msg.swarm_size;
    }
    else {
      resolved.swarm_size = 0.0
    }

    if (msg.swarm_shape !== undefined) {
      resolved.swarm_shape = msg.swarm_shape;
    }
    else {
      resolved.swarm_shape = 0
    }

    if (msg.target_area_x_min !== undefined) {
      resolved.target_area_x_min = msg.target_area_x_min;
    }
    else {
      resolved.target_area_x_min = 0.0
    }

    if (msg.target_area_y_min !== undefined) {
      resolved.target_area_y_min = msg.target_area_y_min;
    }
    else {
      resolved.target_area_y_min = 0.0
    }

    if (msg.target_area_x_max !== undefined) {
      resolved.target_area_x_max = msg.target_area_x_max;
    }
    else {
      resolved.target_area_x_max = 0.0
    }

    if (msg.target_area_y_max !== undefined) {
      resolved.target_area_y_max = msg.target_area_y_max;
    }
    else {
      resolved.target_area_y_max = 0.0
    }

    if (msg.attack_target_pos !== undefined) {
      resolved.attack_target_pos = msg.attack_target_pos;
    }
    else {
      resolved.attack_target_pos = new Array(3).fill(0)
    }

    if (msg.formation_poses !== undefined) {
      resolved.formation_poses = new Array(msg.formation_poses.length);
      for (let i = 0; i < resolved.formation_poses.length; ++i) {
        resolved.formation_poses[i] = geometry_msgs.msg.Point.Resolve(msg.formation_poses[i]);
      }
    }
    else {
      resolved.formation_poses = []
    }

    return resolved;
    }
};

// Constants for message
SwarmCommand.Constants = {
  MOCAP: 0,
  GPS: 4,
  RTK: 5,
  UWB: 6,
  READY: 0,
  INIT: 1,
  START: 2,
  HOLD: 3,
  STOP: 4,
  FORMATION: 5,
  COL_AROUND_CIRCLE: 6,
  COL_FOLLOW_UAV: 7,
  COL_FOLLOW_UGV: 8,
  INITPLANNER: 9,
  SWARMFORMATIONPLANNER: 10,
  FOLLOW: 11,
  SEARCH: 12,
  ATTACK: 13,
  ONE_COLUMN: 0,
  TRIANGLE: 1,
  SQUARE: 2,
  CIRCULAR: 3,
  AROUND_CIRCLE: 4,
}

module.exports = SwarmCommand;
