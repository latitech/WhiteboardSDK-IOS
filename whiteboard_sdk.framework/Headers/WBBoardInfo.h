//
//  WhiteboardSize.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "WhiteboardDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBBoardInfo : NSObject
@property (nonatomic,assign) WBBoardStatus status;
@property (nonatomic,assign) float maxWidth;
@property (nonatomic,assign) float maxHeight;
@property (nonatomic,assign) float displayWidth;
@property (nonatomic,assign) float displayHeight;
@property (nonatomic,assign) float xOffset;
@property (nonatomic,assign) float yOffset;
@property (nonatomic,retain) NSString * backgroundColor;


-(instancetype)initWithDictionary:(NSDictionary *)params_;


@end

NS_ASSUME_NONNULL_END
