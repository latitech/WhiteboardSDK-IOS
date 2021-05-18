//
//  Room.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 房间数据
 */
@interface LATRoom : NSObject


/**
 * 聊天室id
 */
@property (nonatomic,assign) NSInteger chatRoomId;

/**
 * 房间id
 */
@property (nonatomic,retain) NSString * roomId;

/**
* 房间云盘id
*/
@property (nonatomic,retain) NSString * fileGroupId;

-(instancetype)initWithParams:(NSInteger)chatId_ room:(NSString *)roomId_ fileGroup:(NSString *)fileGroupId_;
@end

NS_ASSUME_NONNULL_END
