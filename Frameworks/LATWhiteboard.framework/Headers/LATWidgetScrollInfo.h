//
//  LATWidgetScrollInfo.h
//  LATWhiteboard
//
//  Created by mac on 2021/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATWidgetScrollInfo : NSObject
@property (nonatomic,nonnull) NSString * widgetId;
@property (nonatomic,assign) NSInteger scrollToTop;
@property (nonatomic,assign) NSInteger scrollToBottom;


-(instancetype)initWithDictionary:(NSDictionary *)dict_;
@end

NS_ASSUME_NONNULL_END
