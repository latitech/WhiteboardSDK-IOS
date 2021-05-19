//
//  WhiteboardDefine.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/20.
//

#ifndef WhiteboardDefine_h
#define WhiteboardDefine_h

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,LATInputMode)
{
    /**
     * 笔输入模式
     */
    LATInputModePen,
    /**
     * 橡皮输入模式
     */
    LATInputModeErase,
    
    /**
     * 选择输入模式
     */
    LATInputModeSelect,
    /**
     * 几何图形
     */
    LATInputModeGeometry,
    /**
     * 激光笔
     */
    LATInputModeLaser
};
typedef NS_ENUM(NSInteger,LATPenStyle)
{
    /**
    普通笔
     */
    LATPenStyleNormal,
    /**
     mark笔
     */
    LATPenStyleMark,
    /**
     * 激光笔-点
     */
    LATLaserTypeDot = 2,
    
    /**
     * 激光笔-手
     */
    LATLaserTypeHand = 3,
    
    /**
     * 激光笔-白色箭头
     */
    LATLasterTypeWhiteArrow = 4,
    
    /**
     * 激光笔-黑色箭头
     */
    LATLaserTypeBlackArrow = 5,
    
};

typedef NS_ENUM(NSInteger,LATGeometryType)
{
    /**
       * 矩形
       */
      LATGeometryTypeRectangle = 0,

      /**
       * 圆形
       */
      LATGeometryTypeCircle = 1,

      /**
       * 线
       */
      LATGeometryTypeLine = 3,

      /**
       * 箭头
       */
      LATGeometryTypeArrow = 6

};
typedef NS_ENUM(NSInteger,LATBoardStatus) {
    /**
     * 空闲
     */
    LATBoardStatusIdle,

    /**
     * 正在加载
     */
    LATBoardStatusLoading,

    /**
     * 加载成功
     */
    LATBoardStatusSuccessful,

    /**
     * 加载失败
     */
    LATBoardStatusFailed,

    /**
     * 正在重连
     */
    LATBoardStatusReconnecting,

};

typedef NS_ENUM(NSInteger,LATWidgetType) {
    /**
     * 白板
     */
    LATWidgetTypeBoard = 0,

    /**
     * 文件
     */
    LATWidgetTypeFile = 1,

    /**
     * 图片
     */
    LATWidgetTypeImage = 2,

    /**
     * 几何图形
     */
    LATWidgetTypeGeometry = 3,

    /**
     * 选择框
     */
    LATWidgetTypeSelection = 5,
};

typedef NS_ENUM(NSInteger,LATWidgetAction)
{
    /**
     * 上传/插入新widget
     */
    LATWidgetActionUpload,

    /**
     * 删除widget
     */
    LATWidgetActionDelete,

    /**
     * 加载成功
     */
    LATWidgetActionSuccess,

    /**
     * 加载失败
     */
    LATWidgetActionFailed,
};

#endif /* WhiteboardDefine_h */
