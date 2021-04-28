//
//  WidgetActionEvent.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "WhiteboardDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBWidgetActionEvent : NSObject


@property (nonatomic,retain,nonnull) NSString * sessionId;

/**
 * widget类型
 */
@property (nonatomic,assign)  WBWidgetType type;

/**
 * 动作类型
 */

@property (nonatomic,assign)  WBWidgetAction action;

/**
 * widget名称
 */
    
@property (nonatomic,assign,nonnull) NSString * name;


-(instancetype)initWithDictionary:(NSDictionary *)params_;
@end

NS_ASSUME_NONNULL_END
