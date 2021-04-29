//
//  chatboard_network_interface.hpp
//  libIO
//
//  Created by 陈凯 on 2019/7/2.
//  Copyright © 2019 mac zhang. All rights reserved.
//

#ifndef chatboard_network_interface_hpp
#define chatboard_network_interface_hpp

#include <stdio.h>
#include <string>
#include "chatboard_enum.h"
#include <list>

namespace chatboard {
    namespace interface {
        class chatboard_network_interface {
        private:
            //用来存放消息监听的回调
            std::list<chatboard::io::websocketMessage> _message_listening_list;

        public:

            static chatboard_network_interface *instance();

            /**
             设置websocket服务器地址
             
             @param _server 协议
             */
            void set_websocket_server(const std::string &_server);

            /**
             设置websocket消息监听

             @param _messageListening 消息监听
             */
            void set_websocket_message_listening(
                    const chatboard::io::websocketMessage &_messageListening);

            /**
             设置websocket连接中断的监听
             
             @param _abortedListening 连接中断的监听
             */
            void set_websocket_aborted(const chatboard::io::websocketAborted &_abortedListening);

            /**
             设置websocket连接成功的监听
             
             @param _successListening 连接成功的监听
             */
            void set_websocket_connected(const chatboard::io::websocketSuccess &_successListening);

            /**
             保持网络连接发送心跳
             */
            void send_ping();

            /**
             登录
             */
            void login();

            /**
             登出
             */
            void logout();

            /**
             加入房间
             
             @param data 数据
             */
            void join_room(const std::string &data);

            /**
             离开房间
             */
            void leave_room();

            /**
             发送消息
             */
            void send_message(const std::string &_command,const std::string &_data);

            /**
             解析消息
             
             @param _type 类型
             @param _sub_type 子类型
             @param _message 消息
             */
            void parase_message(int _type, int _sub_type, const std::string &_message);

        };
    }
}

#endif /* chatboard_network_interface_hpp */
