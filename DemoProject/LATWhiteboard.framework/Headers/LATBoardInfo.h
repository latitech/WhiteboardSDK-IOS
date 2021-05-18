//
//  WhiteboardSize.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "LATDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATBoardInfo : NSObject
@property (nonatomic,assign) LATBoardStatus status;
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
