//
// Created by 超悟空 on 2019/6/21.
//

#ifndef WHITEBOARDSDK_POINT_HPP
#define WHITEBOARDSDK_POINT_HPP

#include <math.h>

namespace chatboard::common {
    /// 线条中的点
    struct point {
        /// x坐标
        float x = 0;

        /// y坐标
        float y = 0;

        /// 压力值
        float pressure = 0.5f;

        /// 点的时间戳，可能仅为差值时间，处理widget中的点不应该依赖该值
        unsigned long long timestamp = 0;

        /// 计算与另一个点之间的距离
        /// \param another 另一个点
        /// \return 两点间的距离
        float distance(const point &another) const {
            return hypotf(another.x - x, another.y - y);
        }
        friend struct point operator-(const point & left_,const point & right_)
        {
            return point{left_.x - right_.x,left_.y - right_.y};
        }
    };
}

#endif //WHITEBOARDSDK_POINT_HPP
