//
//  WhiteboardDefine.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/20.
//

#ifndef WhiteboardDefine_h
#define WhiteboardDefine_h

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,WBInputMode)
{
    /**
     * 笔输入模式
     */
    WBInputModePen,
    /**
     * 橡皮输入模式
     */
    WBInputModeErase,
    
    /**
     * 选择输入模式
     */
    WBInputModeSelect,
    /**
     * 几何图形
     */
    WBInputModeGeometry
    
};
typedef NS_ENUM(NSInteger,WBPenStyle)
{
    /**
    普通笔
     */
    WBPenStyleNormal,
    /**
     mark笔
     */
    WBPenStyleMark,
    /**
     * 激光笔-点
     */
    WBLaserTypeDot = 2,
    
    /**
     * 激光笔-手
     */
    WBLaserTypeHand = 3,
    
    /**
     * 激光笔-白色箭头
     */
    WBLasterTypeWhiteArrow = 4,
    
    /**
     * 激光笔-黑色箭头
     */
    WBLaserTypeBlackArrow = 5,
    
};

typedef NS_ENUM(NSInteger,WBGeometryType)
{
    /**
       * 矩形
       */
      WBGeometryTypeRectangle = 0,

      /**
       * 圆形
       */
      WBGeometryTypeCircle = 1,

      /**
       * 线
       */
      WBGeometryTypeLine = 3,

      /**
       * 箭头
       */
      WBGeometryTypeArrow = 6

};
typedef NS_ENUM(NSInteger,WBBoardStatus) {
    /**
     * 空闲
     */
    WBBoardStatusIdle,

    /**
     * 正在加载
     */
    WBBoardStatusLoading,

    /**
     * 加载成功
     */
    WBBoardStatusSuccessful,

    /**
     * 加载失败
     */
    WBBoardStatusFailed,

    /**
     * 正在重连
     */
    WBBoardStatusReconnecting,

};

typedef NS_ENUM(NSInteger,WBWidgetType) {
    /**
     * 白板
     */
    WBWidgetTypeBoard = 0,

    /**
     * 文件
     */
    WBWidgetTypeFile = 1,

    /**
     * 图片
     */
    WBWidgetTypeImage = 2,

    /**
     * 几何图形
     */
    WBWidgetTypeGeometry = 3,

    /**
     * 选择框
     */
    WBWidgetTypeSelection = 5,
};

typedef NS_ENUM(NSInteger,WBWidgetAction)
{
    /**
     * 上传/插入新widget
     */
    WBWidgetActionUpload,

    /**
     * 删除widget
     */
    WBWidgetActionDelete,

    /**
     * 加载成功
     */
    WBWidgetActionSuccess,

    /**
     * 加载失败
     */
    WBWidgetActionFailed,
};

#endif /* WhiteboardDefine_h */
