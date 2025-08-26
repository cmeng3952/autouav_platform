#include "rotation_kalman.h"

RotationKalmanFilter::RotationKalmanFilter() 
    : initialized_(false), detection_count_(0) {
    kf_ = cv::KalmanFilter(6, 3, 0, CV_64F); // 6状态（旋转和角速度），3测量（旋转）
    state_ = cv::Mat::zeros(6, 1, CV_64F);
    measurement_ = cv::Mat::zeros(3, 1, CV_64F);

    // 初始化转移矩阵
    kf_.transitionMatrix = (cv::Mat_<double>(6, 6) <<
        1, 0, 0, 1, 0, 0,
        0, 1, 0, 0, 1, 0,
        0, 0, 1, 0, 0, 1,
        0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 1);

    // 测量矩阵
    kf_.measurementMatrix = (cv::Mat_<double>(3, 6) <<
        1, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0);

    // 过程噪声协方差
    setIdentity(kf_.processNoiseCov, cv::Scalar::all(1e-5));
    // 测量噪声协方差
    setIdentity(kf_.measurementNoiseCov, cv::Scalar::all(1e-2));
    // 后验错误协方差
    setIdentity(kf_.errorCovPost, cv::Scalar::all(1));
}

void RotationKalmanFilter::init() {
    initialized_ = true;
}

cv::Vec3d RotationKalmanFilter::update(const cv::Vec3d& measurement, double timestamp) {
    if (!initialized_) {
        init();
        state_.at<double>(0) = measurement[0];
        state_.at<double>(1) = measurement[1];
        state_.at<double>(2) = measurement[2];
        kf_.statePost = state_;
        last_timestamp_ = timestamp;
        detection_count_ = 1;
        return measurement;
    }

    double dt = timestamp - last_timestamp_;
    last_timestamp_ = timestamp;

    // 更新转移矩阵
    kf_.transitionMatrix.at<double>(0, 3) = dt;
    kf_.transitionMatrix.at<double>(1, 4) = dt;
    kf_.transitionMatrix.at<double>(2, 5) = dt;

    // 预测
    state_ = kf_.predict();

    // 更新测量
    measurement_.at<double>(0) = measurement[0];
    measurement_.at<double>(1) = measurement[1];
    measurement_.at<double>(2) = measurement[2];

    // 更新（校正）
    kf_.correct(measurement_);
    state_ = kf_.statePost;

    detection_count_++;
    return cv::Vec3d(state_.at<double>(0), state_.at<double>(1), state_.at<double>(2));
}

cv::Vec3d RotationKalmanFilter::get_rotation() const {
    return cv::Vec3d(state_.at<double>(0), state_.at<double>(1), state_.at<double>(2));
}

int RotationKalmanFilter::get_detection_count() const {
    return detection_count_;
}