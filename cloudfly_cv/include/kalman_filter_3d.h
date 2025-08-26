#ifndef KALMAN_FILTER_3D_H
#define KALMAN_FILTER_3D_H

#include <opencv2/opencv.hpp>

class KalmanFilter3D {
public:
    KalmanFilter3D(double process_noise = 0.001, double measurement_noise = 0.01, double error_cov = 0.1);
    void init();
    cv::Vec3d update(const cv::Vec3d& measurement, double timestamp);
    cv::Vec3d get_position() const { return position_; }
    int get_detection_count() const { return detection_count_; }

private:
    cv::KalmanFilter kf_;
    cv::Vec3d position_;
    cv::Mat state_;
    cv::Mat measurement_;
    double last_timestamp_;
    int detection_count_;
    bool initialized_;
};

#endif // KALMAN_FILTER_3D_H