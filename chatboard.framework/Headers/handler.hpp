//
// Created by 超悟空 on 2019/6/26.
//

#ifndef WHITEBOARDSDK_HANDLER_HPP
#define WHITEBOARDSDK_HANDLER_HPP

#include <functional>
#include <chrono>

namespace chatboard::common {

    /// 消息执行函数
    typedef std::function<void()> runnable;

    /// 需要实现的handler接口
    struct handler_interface {
    public:
        /// 向循环发送一个事件消息以等待执行
        /// \param r 要执行的事件
        virtual void post(const runnable &r) = 0;

        /// 延迟执行
        /// \param d 延迟毫秒数
        /// \param r 要执行的事件
        virtual void delay(const std::chrono::milliseconds &d, const runnable &r) = 0;
    };

    /// 消息循环助手构建工厂，由各平台独立实现
    struct handler_factory {
    public:
        typedef std::shared_ptr<handler_interface> handler_ptr;

        /// 获取主循环
        /// \return 主循环，全局唯一
        virtual handler_ptr get_main_handler() = 0;
    };

    /// 消息循环助手，用于向循环推入事件
    struct handler {
    protected:

        /// 工厂持有者
        struct factory_holder {
            /// handler工厂实例
            std::shared_ptr<handler_factory> factory;

            static factory_holder &instance();
        };

    public:
        /// 设置handler构建工厂
        /// \param factory 工厂实现
        static void set_factory(std::shared_ptr<handler_factory> factory) {
            factory_holder::instance().factory = std::move(factory);
        }

        handler() : _inner(std::move(factory_holder::instance().factory->get_main_handler())) {}

        explicit handler(handler_factory::handler_ptr i) : _inner(std::move(i)) {}

        /// 向循环发送一个事件消息以等待执行
        /// \param r 要执行的事件
        void post(const runnable &r) {
            _inner->post(r);
        };

        /// 延迟执行
        /// \param d 延迟毫秒数
        /// \param r 要执行的事件
        void delay(const std::chrono::milliseconds &d, const runnable &r) {
            _inner->delay(d, r);
        };
    private:

        /// handler实现委托
        handler_factory::handler_ptr _inner;
    };
}

#endif //WHITEBOARDSDK_HANDLER_HPP
