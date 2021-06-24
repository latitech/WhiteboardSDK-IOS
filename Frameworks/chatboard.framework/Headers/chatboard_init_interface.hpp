//
//  chatboard_init_interface.hpp
//  libIO
//
//  Created by 陈凯 on 2019/7/4.
//  Copyright © 2019 mac zhang. All rights reserved.
//

#ifndef chatboard_init_interface_hpp
#define chatboard_init_interface_hpp

#include <stdio.h>
#include <string>
#include <vector>
#include "chatboard_enum.h"
#ifdef _IOS_SDK
#include "pointer_event.hpp"
#else
#include "render/input/event/pointer_event.hpp"
#endif
namespace chatboard::io::input {
   
}

namespace chatboard {
    namespace interface {
        enum class render_type {
            opengl,
            opengl_es2,
            opengl_es3,
            webgl,
            skia,
            nanovg
        };
        //网络请求的方式
        enum class NetworkMethod {
            NetworkMethod_Get = 0,
            NetworkMethod_Post = 1,
            NetworkMethod_Put = 2,
            NetworkMethod_Delete = 3
        };

        class chatboard_init_interface {
        public:

            chatboard_init_interface();

            virtual ~chatboard_init_interface();

        private:

            io::fetchData _fetchData;
            
            io::bufferCallback _bufferCall;

        public:

            static chatboard_init_interface *instance();

            /**
             处理所有UI控制命令
             
             @param _command 对应的类型
             @param _data 命令json
             */
            void push_command(const std::string &_command, const std::string &_data);

            /**
             从白板内获取数据
             
             @param _command 对应的类型
             @param _data json数据
             @return 返回该类型对应的数据
             */
            std::string fetch_data(const std::string &_command, const std::string &_data);

            /**
             白板事件通知
             
             @param _fetch 事件通知
             */
            void on_chatboard_event_fetch_data(io::fetchData _fetch);
            
            /**
             文字生成图片回调

             @param _callback 回调
             */
            void on_chatboard_generate_buffer(io::bufferCallback _callback);

            /**
             初始化render

             @param _type render类型
             */
            void on_graphics_init(int _width,int _height,chatboard::interface::render_type _type,bool _isFlip = false);

            /**
             销毁render
             */
            void on_graphics_destroy();

            /// 设置屏幕刷新监听器
            /// \param listener 监听器
            void set_on_notification_listener(const io::on_refresh &listener);

            /**
             更新屏幕
             
             @return 结果
             */
            bool on_screen_update();

            /**
             更新屏幕尺寸

             @param w 宽
             @param h 高
             */
            void on_screen_size_update( int w, int h);

            /**
             用户手势输入
             */
            void on_pointer_input(int _index, float _x, float _y, float _f,
                                  render::input::status_type _type,
                                  render::input::source_type _source,
                                  unsigned long long _ts, float _size = 0,float _delta_x = 0,float _delta_y = 0,render::input::keyboard_type _keyboard = render::input::keyboard_type::none);


            ///内部使用
            void chatboard_call(const std::string &_command, const std::string &_data,
                                io::taskFinished _fetch = nullptr);
            
            void chatboard_generate_buffer(const std::string &_command,const std::string & _data,chatboard::io::bufferContent _content);
        };
    }
}

#endif /* chatboard_init_interface_hpp */
