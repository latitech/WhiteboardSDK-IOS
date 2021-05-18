//
//  WB_JoinConfig.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface LATJoinInfo : NSObject

/**
 * 应用id
 */
@property (nonatomic,retain,readonly) NSString * appId;
@property (nonatomic,retain,readonly) NSString * roomId;
@property (nonatomic,retain,readonly) NSString * userId;
@property (nonatomic,retain,readonly) NSString * token;

-(instancetype)initWithParam:(NSString *)appId_ room:(NSString *)roomId_ user:(NSString *)userId_ token:(NSString *)token_;

-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
