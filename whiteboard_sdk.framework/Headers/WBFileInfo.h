//
//  WB_FileConfig.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBFileInfo : NSObject
@property (nonatomic,retain) NSString * path;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,assign) float left;
@property (nonatomic,assign) float top;
@property (nonatomic,assign) float width;
@property (nonatomic,assign) float height;

@end

NS_ASSUME_NONNULL_END
