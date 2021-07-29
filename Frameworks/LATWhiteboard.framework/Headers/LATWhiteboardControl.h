//
//  WhiteBoard.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/20.
//

#import <Foundation/Foundation.h>
#include <GLKit/GLKit.h>
#import "Constant.h"
#import "LATRoom.h"
#import "LATInputConfig.h"
#import "LATJoinInfo.h"
#import "LATFileInfo.h"
#import "LATPageInfo.h"
#import "LATActiveWidgetInfo.h"
#import "LATWhiteboardDelegate.h"
#import "LATUIDelegate.h"
#import "LATWidgetScrollInfo.h"
#import "LATWhiteboardConfig.h"


typedef NS_ENUM(NSInteger,LATErrorNo)
{
    LAT_CODE_NETWORK_ERROR=100,//   网络不可用
    LAT_CODE_SERVER_ERROR =101, //   服务器错误或繁忙
    LAT_CODE_APP_ID_NOT_EXIST = 200,  //  appId不存在
    LAT_CODE_ROOM_ID_NOT_EXIST = 201,//    roomId不存在
    LAT_CODE_USER_ID_EMPTY = 202,//    userId为空
    LAT_CODE_TOKEN_ERROR  = 203,//    token错误
    LAT_CODE_CONNECT_ROOM_FAILED = 300, //    连接房间失败
    LAT_CODE_PAGE_INFO_TIMEOUT = 301,//    等待页数据下发超时
    LAT_CODE_ROOM_DISCONNECT = 302,//    房间连接中断，可能是网络波动，也可能是房间中传输了错误数据导致被服务器切断
};

NS_ASSUME_NONNULL_BEGIN

@class LATWhiteboardViewController;
@interface LATWhiteboardControl : NSObject

/**
 *当前加入的房间信息
 */
@property (nonatomic,readonly,retain) LATRoom * room;

/**
 *当前用户的个人信息
 */
@property (nonatomic,retain,readonly) LATRoomMember * me;

@property (nonatomic,readonly) LATWhiteboardConfig * config;
/**
 *当前白板的输入状态
 */
@property (nonatomic,assign,readonly) LATInputConfig * inputConfig;

@property (nonatomic,weak) id<LATUIDelegate> uiDelegate;

+(instancetype)instance;

-(instancetype)init;

-(void)prepareRenderContext:(int)width_ withHeight:(int)height_ context:(EAGLContext *)context_;
-(void)destroyRenderContext;

-(void)updateScreenSize:(float)width_ andHeight:(float)height_;

-(bool)initalizeView;


-(void)reset;
/**
 * 添加一个白板事件监听器。
 * @param delegate_ 监听器实例
 *
 * @implNote 可在任何时期调用
 */
-(void)addListener:(id<LATWhiteboardDelegate>)delegate_;
/**
   * 移除一个白板事件监听器
   *
   * @param delegate_ 监听器实例
   *
   * @implNote 可在任何时期调用
   */
-(void)removeListener:(id<LATWhiteboardDelegate>)delegate_;
/**
 * 清空所有白板监听器
 *
 * @implNote 可在任何时期调用
 */
-(void)clearListener;


/**
 * 进入白板房间
 *
 * 执行此方法可以加入白板房间，加入成功后会收到{@link WhiteBoardDelegate#onJoinSuccess(Room, RoomMember)}回调，
 * 加入失败则会收到{@link WhiteBoardListener#onJoinFailed(int)}回调。
 *
 * 如果已经加入成功但是发生了掉线，则SDK会尝试自动重连，并收到{@link WhiteBoardDelegate#onReconnecting(int)}回调。
 * 重连次数可以通过{@link #setRetry(int)}修改，重连成功后会收到{@link WhiteBoardDelegate#onReconnected()}，重连失败会收到
 * {@link WhiteBoardDelegate#onDisconnected()}，此时必须用户手动调用此方法重新加入房间。
 *
 * @param roomInfo_ 携带的房间和身份信息
 * @param me_ 携带个人信息
 */
-(void)joinRoom:(LATJoinInfo *)roomInfo_ member:(LATRoomMember *)me_;
/**
 * 离开白板房间
 *
 * 关闭白板界面时必须调用此方法以释放所有白板资源
 */

-(void)leaveRoom;

/**
 * 设置白板的默认初始输入模式配置
 *
 * @param config_ 新的输入模式配置，白板加载完成后默认使用的输入模式
 *
 * @implNote 仅在 {@link #joinRoom}之前调用生效
 */
-(void)setDefaultInputMode:(LATInputConfig *)config_;

/**
 * 白板截图
 *
 * @param delegate_ 截图回调
 *
 * @implNote 仅在 {@link WhiteBoardView}加载附加到ViewTree中后有效，回调将在非主线程执行
 */

/**
 更新屏幕内容，一般是自动调用
 */
-(void)updateScreen;

/**
 * 设置白板断线自动重连次数，默认为10次，设为0表示不自动重连
 *
 * @param count 新的重连次数
 */
-(void)setRetry:(int)count_;

/**
 * 改变白板的输入模式
 *
 * @param config_ 新的输入模式配置
 *
 * @implNote 仅在 {@link #joinRoom}之后调用生效
 */
-(void)setInputMode:(LATInputConfig*)config_;

/**
 * 设置白板背景色
 *
 * @param color_ 背景色 格式是 ‘#AARRGGBB'
 *
 * @implNote 仅在房间加入成功后有效，同时会触发{@link WhiteBoardListener#onBackgroundColorChanged(int)}
 */
-(void)setBackgroundColor:(NSString *)color_;

/**
 * 垂直滚动白板显示区
 *
 * @param offsetY_ 垂直偏移量总量
 *
 * @implNote 仅在房间加入成功后有效，同时会触发{@link WhiteBoardListener#onBoardScroll(WhiteBoardViewport)}
 * @see #getViewport()
 */
-(void)scroll:(float)offsetY_;
/**
 * 新建白板页
 *
 * @implNote 仅在房间加入成功后有效，同时会触发以下三个回调
 * @see WhiteBoardDelegate#onCurrentBoardPageChanged(WhiteBoardPage)
 * @see WhiteBoardDelegate#onBoardPageList(List)
 * @see WhiteBoardDelegate#onBoardPageInfoChanged(WhiteBoardPage)
 */
-(void)newBoardPage;

/**
    * 插入新白板页，同时白板会跳转到新插入的页面
    *
    * @param pageId_ 目标插入位置页id，在此页之前插入
    *
    * @implNote 仅在房间加入成功后有效，同时会触发以下三个回调事件
    * @see WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)
    * @see WhiteBoardListener#onBoardPageList(List)
    * @see WhiteBoardListener#onBoardPageInfoChanged(WhiteBoardPage)
    * @see com.latitech.whiteboard.model.WhiteBoardPage
    * @see #getPageList()
    * @see #getCurrentPage()
 */
-(void)insertBoardPage:(NSString *)pageId_;

/**
     * 跳转到目标白板页
     *
     * @param pageId_ 目标页id
     *
     * @implNote 仅在房间加入成功后有效，同时会触发以下两个回调事件
     * @see WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)
     * @see WhiteBoardListener#onBoardPageInfoChanged(WhiteBoardPage)
     * @see com.latitech.whiteboard.model.WhiteBoardPage
     * @see #getPageList()
     * @see #getCurrentPage()
*/
-(void)jumpBoardPage:(NSString *)pageId_;
/**
 
 功能和jumpBoardPage一样，这个版本的参数数字的页码
 */

-(void)switchToPageNumber:(NSInteger)pageNo;
/**
     * 前进到上一页
     *
     * @implNote 仅在房间加入成功后有效，同时会触发以下两个回调事件
     * @see WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)
     * @see WhiteBoardListener#onBoardPageInfoChanged(WhiteBoardPage)
 */
-(void)preBoardPage;

/**
     * 前进到下一页
     *
     * @implNote 仅在房间加入成功后有效，同时会触发以下两个回调事件
     * @see WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)
     * @see WhiteBoardListener#onBoardPageInfoChanged(WhiteBoardPage)
 */
-(void)nextBoardPage;


/**
     * 删除白板页
     *
     * @param pageId_ 要删除的页id
     *
     * @implNote 仅在房间加入成功后有效，一定会触发{@link WhiteBoardListener#onBoardPageList(List)}，如果删除的是当前页会同时触发
     * {@link WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)}
     * @see com.latitech.whiteboard.model.WhiteBoardPage
     * @see #getPageList()
     * @see #getCurrentPage()
*/
-(void)deleteBoardPage:(NSString *)pageId_;

/**
 
 清空指定页的内容
 */
-(void)cleanPage:(NSString *)pageId_;


/**
 生成并且上传thumbail
 必须在主线程下执行
 
 
 */
-(void)updateThumbnailForPageId:(NSString *)pageId_ image:(NSString *)imagePath;




-(void)insertFile:(LATFileInfo *)config_;

/**
     * 文件翻页
     *
     * @param widgetId_ 文件的widgetId
     * @param pageNo_   目标页号，从1开始
     *
     * @implNote 仅在房间加入成功后有效，会同时触发{@link WhiteBoardListener#onFilePageChanged(ActiveWidgetInfo)}
     * @see com.latitech.whiteboard.model.ActiveWidgetInfo
     * @see #getActiveWidget()
     * @see WhiteBoardListener#onWidgetActive(ActiveWidgetInfo)
     */
-(void)jumpFilePage:(NSString *)widgetId_ pageNo:(int)pageNo_;

/**
     * 删除文件
     *
     * @param widgetId_ 要删除的文件widgetId
     *
     * @implNote 仅在房间加入成功后有效，会同时触发{@link WhiteBoardListener#onWidgetActionEvent(WidgetActionEvent)}
     * @see com.latitech.whiteboard.model.ActiveWidgetInfo
     * @see #getActiveWidget()
     * @see WhiteBoardListener#onWidgetActive(ActiveWidgetInfo)
     */
-(void)deleteFile:(nonnull NSString *)widgetId_;

/**
     * 撤销一次擦除的笔迹，仅在橡皮模式下还原擦除的笔迹，
     * 一次擦除的笔迹指用户从落下手指移动擦除线条到抬起手指为止期间擦掉的所有线条。
     * 当输入模式切换或者白板翻页后擦除缓存将会清空。
     *
     * @implNote 仅当 {@link #canRecovery()}返回true时执行有效
     * @see #canRecovery()
     * @see WhiteBoardListener#onRecoveryStateChanged(boolean)
     */
-(void)recover;

/**
    * 获取白板当前状态
    *
    * @return 状态枚举
    *
    * @see WhiteBoardListener#onBoardStatusChanged(BoardStatus)
    */
-(LATBoardStatus)getStatus;
/**
    * 获取当前登录的房间信息
 */

-(LATRoom *)getRoom;

/**
    *获取当前登录的用户信息
 */
-(LATRoomMember *)getMe;
/**
     * 获取当前房间中的用户列表，包括自己
     *
     * @return 一个不可变列表
     *
     * @see WhiteBoardListener#onUserList(List)
     */

-(NSArray<LATRoomMember *> *)getUsers;

/**
 *返回当前的视图区域
 
 */
-(LATBoardInfo *)getViewPort;
/**
     * 获取当前白板的全部页信息列表
     *
     * @return 一个不可变列表
     *
     * @implNote 仅在房间加入成功后才能返回有效数据
     * @see WhiteBoardListener#onBoardPageList(List)
     */
-(NSArray<LATPageInfo *> *)getPageList;

-(LATPageInfo *)getPageByIndex:(NSInteger)index_;
/**
 * 获取当前白板页信息
 *
 * @return 当前页信息
 *
 * @implNote 仅在房间加入成功后才能返回有效数据
 * @see WhiteBoardListener#onCurrentBoardPageChanged(WhiteBoardPage)
 */
-(LATPageInfo *)getCurrentPage;

/**
     * 获取当前显示的白板背景色
     *
     * @return 背景色
     * 颜色规范为 "#AARRGGBB"
     * @implNote 仅在房间加入成功后才能返回有效数据，否则会返回 {@link android.graphics.Color#LTGRAY}
     * @see WhiteBoardListener#onBackgroundColorChanged(int)
     */
-(NSString *)getBackgroundColor;

/**
 *返回当前输入状态
 
 
 */
-(LATInputConfig *)getInputConfig;
/**
     * 获取当前被激活操作的widget
     *
     * @return widget信息实例
     *
     * @implNote 仅在房间加入成功后才能返回有效数据
     * @see WhiteBoardListener#onWidgetActive(ActiveWidgetInfo)
     */
-(LATActiveWidgetInfo *)getActiveWidget;

/**
     * 是否存在可还原的笔迹（擦除还原，仅对笔迹有效）
     *
     * @return true表示有可还原的笔迹，此时可通过调用{@link #revert()}来还原一次擦除操作
     *
     * @implNote 仅在房间加入成功后才能返回有效数据
     * @see #revert()
     * @see WhiteBoardListener#onRecoveryStateChanged(boolean)
 */
-(BOOL)CanRecovery;

/**
   * 获取当前白板的窗口尺寸信息，包括白板的大小和偏移
   *
   * @return 可视区信息
   *
   * @implNote 仅在房间加入成功后才能返回有效数据
   * @see #scroll(float)
   * @see WhiteBoardListener#onBoardScroll(WhiteBoardViewport)
   * @see WhiteBoardListener#onBoardSizeChanged(WhiteBoardViewport)
   */
-(LATBoardInfo *)getBoardInfo;

-(void)onPointerInput:(UITouchPhase)type at:(CGPoint)position force:(float)force withId:(int)index isPencil:(bool)isPencil timestamp:(unsigned long long)ts;


-(int)getMaxPageNumber;

@end
NS_ASSUME_NONNULL_END
