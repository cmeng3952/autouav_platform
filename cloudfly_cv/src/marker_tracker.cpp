#include "marker_tracker.h"

MarkerTracker::MarkerTracker(int min_detections) : min_detections_(min_detections) {}

void MarkerTracker::update(const std::vector<int>& ids, const std::vector<cv::Vec3d>& positions, 
                            const std::vector<cv::Vec3d>& rotations,double timestamp) {
    // 更新位置 旋转跟踪器
    for (size_t i = 0; i < ids.size(); i++) {
        int id = ids[i];
        if (markers_.find(id) == markers_.end()) {
            // 旋转和位置
            MarkerState new_state;
            new_state.kf = KalmanFilter3D();
            new_state.rot_kf = RotationKalmanFilter();
            new_state.last_detected = timestamp;
            new_state.corner_filters = std::vector<KalmanFilter2D>(4);
            new_state.active = true;
            markers_[id] = new_state;
            // 只有位置
            // markers_[id] = {KalmanFilter3D(), 0, std::vector<KalmanFilter2D>(4), false};
        }
        
        auto& state = markers_[id];
        cv::Vec3d filtered_pos = state.kf.update(positions[i], timestamp);
        
        cv::Vec3d filtered_rot = state.rot_kf.update(rotations[i], timestamp);

        state.last_detected = timestamp;
        state.active = true;
    }
    
    // 标记未检测到的目标
    double current_time = timestamp;
    for (auto& kv : markers_) {
        if (current_time - kv.second.last_detected > 0.5) { // 0.5秒未检测到设为非活跃
            kv.second.active = false;
        }
    }
}

void MarkerTracker::updateCorners(int id, const std::vector<cv::Point2f>& corners) {
    if (markers_.find(id) != markers_.end()) {
        auto& state = markers_[id];
        
        // 初始化角点滤波器
        if (state.corner_filters.empty()) {
            state.corner_filters = std::vector<KalmanFilter2D>(4);
        }
        
        // 更新每个角点的位置
        for (int i = 0; i < 4; i++) {
            state.corner_filters[i].update(corners[i]);
        }
    }
}

std::map<int, cv::Vec3d> MarkerTracker::get_stable_positions(int min_detections) {
    if (min_detections < 0) min_detections = min_detections_;
    
    std::map<int, cv::Vec3d> result;
    for (auto& kv : markers_) {
        if (kv.second.kf.get_detection_count() >= min_detections && kv.second.active) {
            result[kv.first] = kv.second.kf.get_position();
        }
    }
    return result;
}

std::map<int, cv::Vec3d> MarkerTracker::get_stable_rotations(int min_detections) {
    if (min_detections < 0) min_detections = min_detections_;
    
    std::map<int, cv::Vec3d> result;
    for (auto& kv : markers_) {
        if (kv.second.detection_count >= min_detections && kv.second.active) {
            result[kv.first] = kv.second.rot_kf.get_rotation();
        }
    }
    return result;
}

std::vector<cv::Point2f> MarkerTracker::get_smoothed_corners(int id) {
    std::vector<cv::Point2f> corners;
    if (markers_.find(id) != markers_.end()) {
        auto& state = markers_[id];
        if (state.corner_filters.size() == 4) {
            for (auto& filter : state.corner_filters) {
                corners.push_back(filter.get_estimated());
            }
        }
    }
    return corners;
}