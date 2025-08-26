#include "kalman_filter_2d.h"

KalmanFilter2D::KalmanFilter2D(double process_noise, double measurement_noise, double error_cov)
    : initialized_(false) {
    kf_ = cv::KalmanFilter(4, 2, 0);
    state_ = cv::Mat::zeros(4,1,CV_32F);
    measurement_ = cv::Mat::zeros(2,1,CV_32F);

    // 状态转移矩阵 (x, y, vx, vy)
    kf_.transitionMatrix = (cv::Mat_<float>(4, 4) << 
        1, 0, 1, 0,
        0, 1, 0, 1,
        0, 0, 1, 0,
        0, 0, 0, 1);
    
    // 测量矩阵 (只测量位置)
    kf_.measurementMatrix = (cv::Mat_<float>(2, 4) << 
        1, 0, 0, 0,
        0, 1, 0, 0);
        
    // 过程噪声协方差
    cv::setIdentity(kf_.processNoiseCov, cv::Scalar::all(process_noise));
    
    // 测量噪声协方差
    cv::setIdentity(kf_.measurementNoiseCov, cv::Scalar::all(measurement_noise));
    
    // 后验误差协方差
    cv::setIdentity(kf_.errorCovPost, cv::Scalar::all(error_cov));
}

void KalmanFilter2D::init(const cv::Point2f& pt) {
    kf_.statePost = (cv::Mat_<float>(4, 1) << pt.x, pt.y, 0, 0);
    state_.at<float>(0) = pt.x;
    state_.at<float>(1) = pt.y;
    last_estimated_ = pt;
    initialized_ = true;
}

cv::Point2f KalmanFilter2D::update(const cv::Point2f& measurement) {
    if (!initialized_) {
        init(measurement);
        return measurement;
    }
    
    // 预测
    cv::Mat prediction = kf_.predict();
    state_ = kf_.predict();
    cv::Point2f predict_pt(prediction.at<float>(0), prediction.at<float>(1));
    
    // 更新
    cv::Mat measurementMat(2, 1, CV_32F);
    measurementMat.at<float>(0) = measurement.x;
    measurementMat.at<float>(1) = measurement.y;
    cv::Mat estimated = kf_.correct(measurementMat);

    measurement_.at<float>(0) = measurement.x;
    measurement_.at<float>(1) = measurement.y;
    kf_.correct(measurement_);
    state_ = kf_.statePost;
    
    
    last_estimated_ = cv::Point2f(estimated.at<float>(0), estimated.at<float>(1));
    return last_estimated_;
}
// cv::Point2f KalmanFilter2D::get_estimated() const {
//     return cv::Point2f(state_.at<float>(0), state_.at<float>(1));
// }