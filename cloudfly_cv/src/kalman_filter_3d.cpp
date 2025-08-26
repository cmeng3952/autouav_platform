#include "kalman_filter_3d.h"

KalmanFilter3D::KalmanFilter3D(double process_noise, double measurement_noise, double error_cov)
    : position_(0, 0, 0), last_timestamp_(0), detection_count_(0), initialized_(false) {
    
    kf_ = cv::KalmanFilter(6, 3, 0);
    state_ = cv::Mat::zeros(6,1,CV_32F);
    measurement_ = cv::Mat::zeros(3,1,CV_32F);
    // 状态转移矩阵 (x, y, z, vx, vy, vz)
    kf_.transitionMatrix = (cv::Mat_<float>(6, 6) << 
        1, 0, 0, 1, 0, 0,
        0, 1, 0, 0, 1, 0,
        0, 0, 1, 0, 0, 1,
        0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 1);
    
    // 测量矩阵 (只测量位置)
    kf_.measurementMatrix = (cv::Mat_<float>(3, 6) << 
        1, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0);
        
    // 过程噪声协方差
    cv::setIdentity(kf_.processNoiseCov, cv::Scalar::all(process_noise));
    
    // 测量噪声协方差
    cv::setIdentity(kf_.measurementNoiseCov, cv::Scalar::all(measurement_noise));
    
    // 后验误差协方差
    cv::setIdentity(kf_.errorCovPost, cv::Scalar::all(error_cov));
}
void KalmanFilter3D::init() {
    initialized_ = true;
}
cv::Vec3d KalmanFilter3D::update(const cv::Vec3d& measurement, double timestamp) {
    if (!initialized_) {
        // 初始化状态
        kf_.statePost = (cv::Mat_<float>(6, 1) << 
            measurement[0], measurement[1], measurement[2], 0, 0, 0);
        state_.at<float>(0) = measurement[0];
        state_.at<float>(1) = measurement[1];
        state_.at<float>(2) = measurement[2];
        position_ = measurement;
        last_timestamp_ = timestamp;
        initialized_ = true;
        detection_count_ = 1;
        return position_;
    }
    
    // 计算时间差
    double dt = timestamp - last_timestamp_;
    last_timestamp_ = timestamp;
    
    // 更新状态转移矩阵中的时间因子
    kf_.transitionMatrix.at<float>(0, 3) = dt;
    kf_.transitionMatrix.at<float>(1, 4) = dt;
    kf_.transitionMatrix.at<float>(2, 5) = dt;
    
    // 预测
    cv::Mat prediction = kf_.predict();
    state_ = kf_.predict();
    
    // 更新
    cv::Mat measurementMat(3, 1, CV_32F);
    measurementMat.at<float>(0) = measurement[0];
    measurementMat.at<float>(1) = measurement[1];
    measurementMat.at<float>(2) = measurement[2];
    
    cv::Mat estimated = kf_.correct(measurementMat);

    kf_.correct(measurementMat);
    state_ = kf_.statePost;

    position_ = cv::Vec3d(
        estimated.at<float>(0), 
        estimated.at<float>(1), 
        estimated.at<float>(2)
    );
    
    detection_count_++;
    return position_;
}


// cv::Vec3d KalmanFilter3D::get_position() const {
//     return cv::Vec3d(state_.at<float>(0), state_.at<float>(1), state_.at<float>(2));
// }

// int KalmanFilter3D::get_detection_count() const {
//     return detection_count_;
// }