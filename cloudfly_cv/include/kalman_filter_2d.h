#ifndef KALMAN_FILTER_2D_H
#define KALMAN_FILTER_2D_H

#include <opencv2/opencv.hpp>

class KalmanFilter2D {
public:
    KalmanFilter2D(double process_noise = 0.01, double measurement_noise = 0.1, double error_cov = 0.1);
    
    void init(const cv::Point2f& pt);
    cv::Point2f update(const cv::Point2f& measurement);
    cv::Point2f get_estimated() const { return last_estimated_; }

private:
    cv::KalmanFilter kf_;
    bool initialized_;
    cv::Mat state_;
    cv::Mat measurement_;
    cv::Point2f last_estimated_;
};

#endif // KALMAN_FILTER_2D_H