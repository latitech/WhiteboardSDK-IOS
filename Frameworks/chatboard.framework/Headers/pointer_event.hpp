#ifndef POINTER_EVENT_HPP
#define POINTER_EVENT_HPP

#include "base_event.hpp"
#ifdef _IOS_SDK
#include "point.hpp"
#else
#include "common/point.hpp"
#endif
namespace chatboard::render::input {

    class pointer_event : public base_event {
    public:
        virtual ~pointer_event() override;

    public:
        pointer_event(int id);

        unsigned int id() const;

        const common::point & position() const;
    
        keyboard_type keyboard() const;
        
        void set_keyboard(keyboard_type keyboard_type_);

        void set_position(const common::point &position_);

        float size() const;

        void set_size(float size);

        std::string desc() override;
        
        void set_delta(float delta_x,float deleta_y);

        float delta_x() const;
        float delta_y() const;
    protected:
        common::point _position;
        unsigned int _id;
        
        float _delta_x;
        float _delta_y;
        keyboard_type _keyboard_type;

        /// 接触面积
        float _size = 0;
    };
}
typedef std::shared_ptr<chatboard::render::input::pointer_event> pointer_evt_ptr;

#endif // POINTER_EVENT_HPP
