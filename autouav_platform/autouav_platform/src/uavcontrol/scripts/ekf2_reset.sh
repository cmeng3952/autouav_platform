#!/bin/bash

# EKF2 Reset Script for PX4 Autopilot
# 通过串口模拟发送mavlink协议消息至PX4飞控，重置EKF2功能

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 默认参数
UAV_ID=2
COMMAND="reset"

# 使用说明
function show_usage() {
    echo -e "${BLUE}================================================================${NC}"
    echo -e "${BLUE}                    EKF2 Reset Tool${NC}"
    echo -e "${BLUE}================================================================${NC}"
    echo -e "${GREEN}用法:${NC}"
    echo -e "  $0 [UAV_ID] [COMMAND]"
    echo ""
    echo -e "${GREEN}参数:${NC}"
    echo -e "  UAV_ID   - 无人机ID (默认: 2)"
    echo -e "  COMMAND  - 操作命令 (默认: reset)"
    echo ""
    echo -e "${GREEN}可用命令:${NC}"
    echo -e "  ${YELLOW}reset${NC}  - 执行完整EKF2重置 (ekf2 stop + 等待3秒 + ekf2 start)"
    echo -e "  ${YELLOW}stop${NC}   - 仅发送 'ekf2 stop' 命令"
    echo -e "  ${YELLOW}start${NC}  - 仅发送 'ekf2 start' 命令"
    echo -e "  ${YELLOW}service${NC}- 启动服务模式（保持节点运行，等待服务调用）"
    echo ""
    echo -e "${GREEN}使用示例:${NC}"
    echo -e "  $0 2 reset          # 对UAV2执行完整EKF2重置"
    echo -e "  $0 1 stop           # 对UAV1发送ekf2 stop命令"
    echo -e "  $0 3 start          # 对UAV3发送ekf2 start命令"
    echo -e "  $0 2 service        # 启动UAV2的EKF2重置服务"
    echo ""
    echo -e "${GREEN}服务调用示例:${NC}"
    echo -e "  rosservice call /uav2/ekf2_reset"
    echo ""
    echo -e "${GREEN}Launch文件使用:${NC}"
    echo -e "  roslaunch uavcontrol ekf2_reset.launch uav_id:=2 command:=reset"
    echo ""
    echo -e "${GREEN}注意事项:${NC}"
    echo -e "  - 确保已启动mavros连接 (roslaunch uavcontrol px4.launch)"
    echo -e "  - 确保PX4飞控已连接且可通过串口通信"
    echo -e "  - EKF2重置会暂时影响定位，请在安全环境下使用"
    echo -e "${BLUE}================================================================${NC}"
}

# 检查参数
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage
    exit 0
fi

# 解析参数
if [ $# -ge 1 ]; then
    UAV_ID=$1
fi

if [ $# -ge 2 ]; then
    COMMAND=$2
fi

# 验证UAV_ID
if ! [[ "$UAV_ID" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}错误: UAV_ID 必须是数字${NC}"
    show_usage
    exit 1
fi

# 验证COMMAND
case $COMMAND in
    "reset"|"stop"|"start"|"service")
        ;;
    *)
        echo -e "${RED}错误: 无效的命令 '$COMMAND'${NC}"
        echo -e "${YELLOW}可用命令: reset, stop, start, service${NC}"
        exit 1
        ;;
esac

# 检查ROS环境
if [ -z "$ROS_PACKAGE_PATH" ]; then
    echo -e "${RED}错误: 未检测到ROS环境，请先source setup.bash${NC}"
    exit 1
fi

# 检查mavros连接
echo -e "${BLUE}检查mavros连接状态...${NC}"
if ! rostopic list | grep -q "/uav$UAV_ID/mavros"; then
    echo -e "${RED}警告: 未检测到UAV$UAV_ID的mavros连接${NC}"
    echo -e "${YELLOW}请先启动: roslaunch uavcontrol px4.launch${NC}"
    read -p "是否继续? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 执行命令
echo -e "${GREEN}执行EKF2操作...${NC}"
echo -e "${BLUE}UAV ID: $UAV_ID${NC}"
echo -e "${BLUE}命令: $COMMAND${NC}"
echo ""

if [ "$COMMAND" == "service" ]; then
    echo -e "${GREEN}启动EKF2重置服务节点...${NC}"
    echo -e "${YELLOW}服务地址: /uav$UAV_ID/ekf2_reset${NC}"
    rosrun uavcontrol ekf2_reset_node _uav_id:=$UAV_ID
else
    echo -e "${GREEN}执行EKF2命令: $COMMAND${NC}"
    rosrun uavcontrol ekf2_reset_node _uav_id:=$UAV_ID $COMMAND
fi

echo -e "${GREEN}操作完成!${NC}"
