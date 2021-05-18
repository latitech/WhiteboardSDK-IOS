//
//  ActiveWidgetInfo.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "LATDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATActiveWidgetInfo : NSObject

/**
 * widgetId
 */
@property (nonatomic,retain,nonnull)  NSString * widgetId;

/**
 * widget类型
 */
@property (nonatomic,assign)  LATWidgetType type;

/**
 * 创建者id
 */
@property (nonatomic,retain,nonnull)  NSString * userId;

/**
 是否已被删除
 */
@property (nonatomic,assign) BOOL isDeleted;
/**
 * 文件名
 */
@property (nonatomic,retain)  NSString * name;

/**
 * 资源id
 */
@property (nonatomic,retain)  NSString * resourceId;

/**
 * 文件路径
 */
@property (nonatomic,retain)  NSString * path;

/**
 * 当前页码({@link WidgetType#FILE}时有意义），从1开始
 */
@property (nonatomic,assign)  int currentPageNumber;

/**
 * 总页数({@link WidgetType#FILE}时有意义）
 */
@property (nonatomic,assign)  int pageCount;


-(instancetype)initWithDictionary:(NSDictionary *)dict_;
@end

NS_ASSUME_NONNULL_END
