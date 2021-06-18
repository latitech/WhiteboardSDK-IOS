#ifndef TIMEUTIL_H
#define TIMEUTIL_H
#include <chrono>
#include <ctime>
#include <atomic>
namespace chatboard::common
{
typedef unsigned long long millisecs;
typedef unsigned long long microsecs;
class time_util
{
public:
    static millisecs now_in_ms()
    {
//        auto now = std::time(nullptr);
 //       return static_cast<std::chrono::milliseconds>(now).count();
        std::chrono::time_point<std::chrono::system_clock,std::chrono::milliseconds> tp = std::chrono::time_point_cast<std::chrono::milliseconds>(std::chrono::system_clock::now());
        return std::chrono::duration_cast<std::chrono::milliseconds>(tp.time_since_epoch()).count();
    }
    static microsecs now_in_micro()
    {
//        auto now = std::time(nullptr);
 //       return static_cast<std::chrono::milliseconds>(now).count();
        std::chrono::time_point<std::chrono::system_clock,std::chrono::microseconds> tp = std::chrono::time_point_cast<std::chrono::microseconds>(std::chrono::system_clock::now());
        return std::chrono::duration_cast<std::chrono::microseconds>(tp.time_since_epoch()).count();
    }
};

}
using millisecs = chatboard::common::millisecs;
using microsecs = chatboard::common::microsecs;
#endif // TIMEUTIL_H
