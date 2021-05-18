//
//  WhiteboardConfig.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATWhiteboardConfig : NSObject
@property (nonatomic,retain,readonly) NSString * ossBucket;
@property (nonatomic,retain,readonly) NSString * ossEndPoint;
@property (nonatomic,retain,readonly) NSString * ossStsUrl;
@property (nonatomic,retain,readonly) NSString * sdkApiHost;
@property (nonatomic,retain,readonly) NSString * sdkFileHost;
@property (nonatomic,retain,readonly) NSString * thumbnailsBucket;
@property (nonatomic,retain,readonly) NSString * thumbnailsFileGroupId;
@property (nonatomic,retain,readonly) NSString * thumbnailsHost;
@property (nonatomic,retain,readonly) NSString * webSocketHost;
@property (nonatomic,retain,readonly) NSString * joinString;

-(instancetype)initWithDictionary:(NSDictionary *)dict_;
@end

NS_ASSUME_NONNULL_END
