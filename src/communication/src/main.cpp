#include "communication_bridge.hpp"

int main(int argc, char **argv)
{
    ros::init(argc, argv, "ground_station_bridge");
    ros::NodeHandle nh("~");

    printf("\033[1;32m---->[ground_station_bridge] start running\n\033[0m");

    CommunicationBridge communication_bridge_(nh);

    ros::AsyncSpinner spinner(4);
    spinner.start();
    ros::waitForShutdown();

    ros::spin();

    return 0;
}
