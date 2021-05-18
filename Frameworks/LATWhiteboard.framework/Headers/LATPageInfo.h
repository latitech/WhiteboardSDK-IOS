//
//  WB_BoardPage.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATPageInfo : NSObject
/**
 * 页id
 */
@property (nonatomic,retain,nonnull) NSString * pageId;
/**
 * 页号
 */
@property (nonatomic,assign) unsigned long pageNumber;
/**
 * 白板缩略图，没有时为空字符串
 */
@property (nonatomic,retain) NSString * thumbUrl;

@property (nonatomic,retain) NSString * backgroundColor;

@property (nonatomic,assign) unsigned long lastUpdateTime;


-(instancetype)initFromDictonary:(NSDictionary *)params_;

-(NSString *)getThumbnailUrl;
@end

NS_ASSUME_NONNULL_END
