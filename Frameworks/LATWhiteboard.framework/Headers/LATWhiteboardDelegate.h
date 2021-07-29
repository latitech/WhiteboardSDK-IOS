//
//  WhiteboardDelegate.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/20.
//

#import <Foundation/Foundation.h>
#import "LATRoom.h"
#import "LATRoomMember.h"
#import "LATBoardInfo.h"
#import "LATWidgetScrollInfo.h"
#import "LATActiveWidgetInfo.h"
#import "LATWidgetActionEvent.h"
#import "LATInputConfig.h"
#import "LATFileInfo.h"
#import "LATPageInfo.h"



NS_ASSUME_NONNULL_BEGIN

@protocol LATWhiteboardDelegate <NSObject>
/**
  * 成功加入白板房间，进入成功后的第一个事件
  *
  * @param  room 房间信息
  * @param me   个人信息
  */
@optional
-(void) onJoinSuccess:(LATRoom *)room_ who:(LATRoomMember *)me_;

 /**
  * 加入房间失败，首次执行加入房间即{@link WhiteBoard#joinRoom(JoinConfig)}执行失败后调用。
  * 因为并没有成功加入房间，所以不会执行自动重连。
  *
  * @param errorCode 错误码 {@link com.latitech.whiteboard.type.ErrorCode}
  */
-(void) onJoinFailed:(int)errorCode_;

 /**
  * 白板正在自动重连，
  * 重连成功后会先触发{@link #onJoinSuccess(Room , RoomMember)}后触发{@link #onReconnected()}，
  * 重连失败后会触发{@link #onDisconnected()}。
  * 首次调用{@link WhiteBoard#joinRoom(JoinConfig)}失败不会自动重连，而是触发{@link #onJoinFailed(int)}
  *
  * @param time 当前为第几次重试
  *
  * @see WhiteBoard#setRetry(int)
  */
@optional
-(void) onReconnecting:(int)time_;

 /**
  * 自动重连成功
  *
  * @see #onReconnecting(int)
  */
@optional
-(void) onReconnected;

 /**
  * 房间彻底断开连接，即在{@link #onReconnecting(int)}超出最大重试次数后触发，
  * 此时需要用户重新执行{@link WhiteBoard#joinRoom(JoinConfig)}加入房间
  */
@optional
-(void) onDisconnected;

/**
 白板的内容或者布局发生变化，需要更新屏幕
 */
-(void)onScreenDirty;

 /**
  * 白板房间状态变化时触发
  *
  * @param status 新的状态
  *
  * @apiNote 当前只要状态变化就会触发，比如在{@link #onJoinSuccess}之前会触发{@link BoardStatus#LOADING}的变化
  * @see WhiteBoard#getStatus()
  */
@optional
-(void) onBoardStatusChanged:(LATBoardStatus)status_;

 /**
  * 当前已经在房间中的用户列表，包括自己，
  * 如果自己管理用户列表，需要以此回调的作为列表初始数据，并且在重连成功后重置初始列表
  *
  * @param users 不可变用户信息列表
  *
  * @apiNote 加入房间后触发一次，自动重连成功后也会触发
  * @see WhiteBoard#getUsers()
  */
@optional
-(void) onUserList:(NSArray *)users_;

 /**
  * 有其它用户加入了房间
  *
  * @param user 用户信息
  */
@optional
-(void) onUserJoin:(LATRoomMember *)user_;
 /**
  * 有其它用户离开了房间
  *
  * @param user 用户信息
  */
@optional
-(void) onUserLeave:(LATRoomMember *)user_;

 /**
  * 白板页信息列表，在首次进入房间和白板页列表结构变化时触发，
  * 比如新增页，删除页等等
  *
  * @param list 不可变列表
  */
@optional
-(void) onBoardPageList:(NSArray *)list;

 /**
  * 白板当前页变化，在首次加入房间后和翻页时触发
  *
  * @param page_ 当前显示页的信息
  */
@optional
-(void)onCurrentBoardPageChanged:(LATPageInfo *)page_;

 /**
  * 某一个白板页信息变化，可能是当前页，也可能不是
  *
  * @param page_ 当前页信息
  *
  * @apiNote 当前实现的触发时机为翻页后上个页面的缩略图地址更新，不会触发当前页更新
  */
@optional
-(void)onBoardPageInfoChanged:(LATPageInfo *)page_;

 /**
  * 在白板的虚拟大小发生变化时触发，首次进入白板也会触发
  *
  * @param info_ 完整的白板状态
  */
@optional
-(void)onBoardSizeChanged:(LATBoardInfo*)info_;

 /**
  * 白板内发生滚动时触发，首次进入白板也会触发
  *
  * @param info_ 新的白板窗口数据,这里的结构是完整的白板信息
  */
@optional
-(void)onBoardScroll:(LATBoardInfo*)info_;


/**
 页面被清空
 @param pageId_ 被清空页面的id
 */
@optional
-(void)onBoardCleaned:(NSString *)pageId_;


 /**
  * 白板背景色变化时触发，首次进入白板也会触发
  *
  * @param backgroundColor 新的白板背景色
  */
@optional
-(void)onBackgroundColorChanged:(NSString *)backgroundColor;

 /**
  * 有新的widget被激活，也就是用户手势触碰到的widget
  * 当此widget是文件，并且此文件发生翻页后会再次触发此回调，同时触发{@link #onFilePageChanged(ActiveWidgetInfo)}
  *
  * @param info widget信息，当白板首次加载或翻页时会回调空值，此时代表用户还没有操作
  */
@optional
-(void)onWidgetActive:(LATActiveWidgetInfo * _Nullable)info;

 /**
  * 文件被翻页时触发，同时触发{@link #onWidgetActive(ActiveWidgetInfo)}
  *
  * @param info 文件widget信息
  */


@optional
-(void)onFilePageChanged:(LATActiveWidgetInfo *)info;

/**
 文档被滚动到顶部或者底部时触发
 @param 文档滚动信息
 */
@optional
-(void)onWidgetScrolled:(LATWidgetScrollInfo *)info;

 /**
  * 当widget被执行了某些关键动作时触发，比如新增和删除文件等
  *
  * @param event 事件信息
  */
@optional
-(void)onWidgetActionEvent:(LATWidgetActionEvent *)event;

 /**
  * 笔迹回收站状态变化，当在擦除模式擦除笔迹或还原笔迹时触发。
  * 在输入模式切换或翻页后会自动清空回收站，同样有可能触发。
  *
  * @param isEmpty 笔迹回收站是否为空，当不为空时可以通过调用{@link WhiteBoard#revert()}还原一次擦除
  *
  * @see WhiteBoard#revert()
  * @see WhiteBoard#canRecovery()
  */
@optional
-(void)onRecoveryStateChanged:(BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
