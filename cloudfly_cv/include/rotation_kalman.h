#ifndef ROTATION_KALMAN_FILTER_H
#define ROTATION_KALMAN_FILTER_H

#include <opencv2/opencv.hpp>

class RotationKalmanFilter {
public:
    RotationKalmanFilter();
    void init();
    cv::Vec3d update(const cv::Vec3d& measurement, double timestamp);
    cv::Vec3d get_rotation() const;
    int get_detection_count() const;

private:
    cv::KalmanFilter kf_;
    cv::Mat state_;
    cv::Mat measurement_;
    double last_timestamp_;
    bool initialized_;
    int detection_count_;
};

#endif // ROTATION_KALMAN_FILTER_H