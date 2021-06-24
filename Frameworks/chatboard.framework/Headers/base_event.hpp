//
//  base_event.hpp
//  libRender
//
//  Created by mac on 2021/4/9.
//  Copyright © 2021 mac zhang. All rights reserved.
//

#ifndef base_event_hpp
#define base_event_hpp

#include <stdio.h>
#include <string>
#ifdef _IOS_SDK
#include "timeutil.h"
#else
#include "common/timeutil.h"
#endif
namespace chatboard::render::input
{
enum class event_type {
    pointer,
    keyboard,
    voice
};

enum class source_type {
    mouse_left,
    mouse_right,
    keyboard,
    pen,
    touch,
    remote,
    wheel
};
enum class status_type {
    start,
    pending,
    end,
    cancel,
    stationary,
    hover,
    wheel
};
enum class keyboard_type{
    none,
    ctrl,
    shift,
    alt,
    up,
    down,
    left,
    right
};
class base_event
{
public:
    virtual ~base_event() = 0;
public:
    source_type source() const;

    status_type status() const;

    event_type type() const;
    
    void set_ts(unsigned long long ts);
    void set_status(status_type status_);
    void set_source(source_type source_);
    unsigned long long get_ts();
    virtual std::string desc() = 0;
protected:
    
protected:
    source_type _source;
    status_type _status;
    event_type _type;
    millisecs _ts;
};
}
#endif /* base_event_hpp */
