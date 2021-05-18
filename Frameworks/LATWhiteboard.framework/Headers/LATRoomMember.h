//
//  RoomMember.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 房间中成员信息对象
 */
@interface LATRoomMember : NSObject

/**
 * 用户业务系统中的稳定用户id
 *
 * @see JoinConfig#userId
 */
@property (nonatomic,retain) NSString * userId;

/**
 * 用户会话id
 *
 * @see JoinConfig#sessionId
 */
@property (nonatomic,retain) NSString * sessionId;

/**
 * 角色id
 */

@property (nonatomic,assign) NSInteger roleId;

/**
 * 用户昵称
 */

@property (nonatomic,retain) NSString * nickName;
/**
 * 用户头像
 */
@property (nonatomic,retain) NSString * avatar;

-(instancetype)initWithParams:(NSString *)userId_ session:(NSString *)sesionId_ role:(NSInteger)roleId_ name:(NSString *)name_ avatar:(NSString *)avatar_;

-(NSDictionary *)toDictionary;
@end
NS_ASSUME_NONNULL_END
