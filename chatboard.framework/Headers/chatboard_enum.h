#ifndef LATITECH_WHITEBOARD_SDK_H
#define LATITECH_WHITEBOARD_SDK_H

#include <functional>

namespace chatboard {
    namespace io {
    
        enum class WidgetActionType{
            Upload = 0,
            Delete = 1
        };
        
        enum class WidgetType
        {
            Document = 0,
            File = 1,
            Image = 2,
            Geometry = 3,
            Unknow = 4,
            Select = 5,
            Svg = 6,
            Text = 7
        };
        
        enum class InputMode
        {
            Draw = 0,
            Erase = 1,
            Select = 2,
            Geometry = 3,
            Text = 4
        };
        
        enum class GometryMode
        {
            rectangle,
            circle,
            triangle,
            line,
            arc,
            angle,
            arrow,
            double_arrow,
            imaginary_line,
            oval,
        };
        
        enum class Message_Type {

            MeetingControl = 0,

            MeetingData = 1,

            SeverNotice = 2,

            Chat = 3,

            Common = 4,

            File = 5,

            MeetingStatus = 6,

            Exception = 7,

            UserPrivilege = 8,

            User = 9,

            Bucket = 10
        };

        enum class MeetingControl_Type {
            room_data = 0,//0-0 房间数据

            user_join = 1, //0-1 用户加入

            user_leave = 2, //0-2 用户离开
        };

        enum class MeetingData_Type {
            action = 0, //1-0 白板全部action数据
        };

        enum class SeverNotice_Type {

            ServerUpgrade = 0 //2-0
        };

        enum class Chat_Type {

            Ack = 0,//3-0

            ChatMessage = 1 //3-1
        };

        enum class Common_Type {
        };

        enum class File_Type {

            FileUploadSuccess = 0 //5-0
        };

        enum class MeetingStatus_Type {

            Open = 0,//开启会议 6-0

            Close = 1,//关闭会议 6-1

            Lock = 2,//锁 6-2

            UnLock = 3,//解锁 6-3

            Stage = 4,//开启举手 6-4

            UnStage = 5,//关闭举手 6-5

            Chat = 6,//聊天 6-6

            UnChat = 7,//关闭聊天 6-7

            SaveFile = 8,//保存文件 6-8

            UnSaveFile = 9,//不允许保存文件 6-9

            FreeSpeak = 10,//开启自由发言 6-10

            UnFreeSpeak = 11,//关闭自由发言 6-11

            Password = 12,//设置密码 6-12

            UnPassword = 13//取消密码 6-13
        };

        enum class Exception_Type {

            MeetingLock = 0,//7-0

            MeetingPasswordError = 1,//7-1

            MeetingTokenError = 2,//7-2

            MeetingAppIdLegal = 3,//7-3

            Not_Privilege = 4,//7-4

            SessionNotExist = 5//7-5
        };

        enum class UserPrivilege_Type {

            Own_Privilege = 0,//发送自己的权限 8-0

            Own_PersonalPrivilege = 1,//自己的个人权限 8-1

            Own_GlobalPrivilege = 2,//自己的全局权限 8-2

            Up_Stage = 3,//有人举手，需要审批 8-3

            Down_Stage = 4,//下麦 8-4

            Other_Privilege = 5,//其他人权限变动 8-5

            Approval_Agree = 6,//审批举手同意 8-6

            Approval_Refuse = 7,//拒绝 8-7

            Role_Change = 8,//角色变动 8-8

            DisableChat = 9,//禁止聊天 8-9

            AbleChat = 10,//减除聊天 8-10

            Kick_Microphone = 11,//使某人下麦 8-11

            Kick_Out = 12,//踢人 8-12

            LowerRoleSize = 13,//低级角色数量 8-13

            Global_Privilege = 14//全局权限变动 8-14
        };

        enum class User_Type {

            LowerRoleList = 0, //9-0

            Examine_Storage = 1 //审核中的人员列表 9-1
        };

        enum class Bucket_Type {

            Info = 0 // 10-0
        };

        enum error {
            /// 登录成功
                    ok = 0,
            /// 认证错误
                    session_auth_credential = 1,
            /// 用户id不存在
                    session_auth_user_nonexistent = 2,
            /// 用户session错误
                    session_auth_session_invalid = 3,
            /// 已经登录
                    session_already_registered = 4,
            /// 网络异常
                    network_connection = 5,
            /// 服务器炸了
                    server_internal = 6,
            /// 加入房间失败
                    room_join_failed = 7,
            /// 离开房间失败
                    room_leave_failed = 8,
            /// 服务器过载
                    server_limit = 9,
            /// 用户主动断开连接
                    user_close = 10
        };

        /**
         用来接收websocket消息的回调
         
         @param type 类型
         @param subType 子类型
         @param data 消息数据
         */
        typedef std::function<void(int type, int subType,
                                   const std::string &data)> websocketMessage;

        /**
         网络连接失败
         */
        typedef std::function<void(int)> websocketAborted;

        /**
         网络连接成功
         */
        typedef std::function<void()> websocketSuccess;

        /**
         当前正在执行中的任务，进度回调
         
         @param _currentProgress 当前进度
         @param _totalProgress 总进度
         */
        typedef std::function<void(long long _currentProgress,
                                   long long _totalProgress)> taskProgress;

        /**
         上传/下载结果回调
         
         @param _result bool value true/false
         @param _data 数据
         */
        typedef std::function<void(bool _result, std::string _data)> taskFinished;

        /**
         文本生成图片得回调

         @param _width 图片宽
         @param _height 图片高
         @param _buffer 图片内容数据流
         */
        typedef std::function<void(int _width, int _height, unsigned char *_buffer)> bufferContent;


        /**
         白板事件通知回调

         @param _command 事件命令
         @param _data 事件数据
         @param _fetch 事件回调，可能为空
         */
        typedef std::function<void(const std::string &_command, const std::string &_data,
                                   taskFinished _fetch)> fetchData;
        
        /**
         文字生成图片回调

         @param _params 参数
         @param _content 回调
         */
        typedef std::function<void(const std::string &_command ,const std::string &_params, bufferContent _content)> bufferCallback;

        /// 通知屏幕刷新回调
        typedef std::function<void()> on_refresh;
    } // namespace whiteboard
} // namespace latitech
#endif // LATITECH_WHITEBOARD_SDK_H
