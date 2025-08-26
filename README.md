# ArUco_Detect

1.消息格式文件在 vision_msgs/msg下

2. 运行：
<<<<<<< HEAD
编译环境：Opencv 4.7.0, PCL 1.10 EIGEN3 Ceres 
(1)git clone https://gitee.com/lxl2333/aruco_detect.git
=======
编译环境：Opencv 4.2.0, PCL 1.10 EIGEN3 Ceres 
(1)git clone https://gitee.com/lxl2333/aruco_detect.git
>>>>>>> modity the detect_ArUco.cpp
(2)catkin_make
(3)source devel/setup.bash
(2)roslaunch cloudply_cv video_dual_pub.launch # Use to publish the image topic /uav1/state
(4)roslaunch cloudfly_cv detect_AruUco.launch
3.相机内参文件格式

intrinsic
841.4936	0	636.6890
0	757.6335	355.5958
0	0	1

distortion
0.1261	-0.1422	0.0	0.0	0.0
4.ArUco二维码尺寸文件格式

1,0.11
2,0.11
3,0.11
4,0.11
43,0.05
19,0.55

