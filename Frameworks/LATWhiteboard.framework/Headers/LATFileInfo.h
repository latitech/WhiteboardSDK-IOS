//
//  WB_FileConfig.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATFileInfo : NSObject
@property (nonatomic,retain) NSString * path;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,assign) NSInteger left;
@property (nonatomic,assign) NSInteger top;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;

-(instancetype)initWithParams:(NSString * _Nonnull)path_ withName:(NSString * _Nullable)name_ withLeft:(NSInteger)left_ withTop:(NSInteger)top_ withWidth:(NSInteger)width_ withHeight:(NSInteger)height_;

@end

NS_ASSUME_NONNULL_END
