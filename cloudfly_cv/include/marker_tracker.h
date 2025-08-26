#ifndef MARKER_TRACKER_H
#define MARKER_TRACKER_H

#include <vector>
#include <map>
#include <opencv2/opencv.hpp>
#include "kalman_filter_3d.h"
#include "kalman_filter_2d.h"
#include "rotation_kalman.h"

class MarkerTracker {
public:
    MarkerTracker(int min_detections = 3);
    
    void update(const std::vector<int>& ids, const std::vector<cv::Vec3d>& positions, 
                const::std::vector<cv::Vec3d>& rotations,double timestamp);
    void updateCorners(int id, const std::vector<cv::Point2f>& corners);
    std::map<int, cv::Vec3d> get_stable_positions(int min_detections = -1);

    std::map<int, cv::Vec3d> get_stable_rotations(int min_detections = -1);

    std::vector<cv::Point2f> get_smoothed_corners(int id);

private:
    struct MarkerState {
        KalmanFilter3D kf;
        RotationKalmanFilter rot_kf;
        double last_detected;
        std::vector<KalmanFilter2D> corner_filters;
        bool active;
        int detection_count;
    };
    
    std::map<int, MarkerState> markers_;
    int min_detections_;
};

#endif // MARKER_TRACKER_H