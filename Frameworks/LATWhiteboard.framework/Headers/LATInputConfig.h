//
//  InputConfig.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "LATDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATInputConfig : NSObject
/**
  * 输入模式
  */

@property (nonatomic,assign) LATInputMode mode;

/**
 笔的类型，目前包括普通笔和马克笔以及激光笔的类型
 */
@property (nonatomic,assign) LATPenStyle penType;

 /**
  * 集合图形类型
  */

@property (nonatomic,assign) LATGeometryType geometryType;

 /**
  * 颜色，支持透明度
  */
@property (nonatomic,retain) NSString * color;

 /**
  * 大小/粗细
  */
@property (nonatomic,assign) float size;

+(instancetype)instanceWithPen:(NSString *)color_ thickness:(float)thickness_;
+(instancetype)instanceWithMark:(NSString *)color_ thickness:(float)thickness_;
+(instancetype)instanceWithLaser:(LATPenStyle)laserType_;
+(instancetype)instanceWithErase:(float)size_;
+(instancetype)instanceWithSelect;
+(instancetype)instanceWithGeometry:(LATGeometryType)geometryType_ color:(NSString *)color_ thickness:(float)thickNess_;

@end

NS_ASSUME_NONNULL_END
