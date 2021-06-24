//
//  WhiteboardUIDelegate.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LATInputConfig.h"
#import "LATActiveWidgetInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LATUIDelegate <NSObject>
-(void)presentViewController:(UIViewController *)controller_;

-(void)addChildView:(UIView *)view_;
-(void)snapShot:(CGRect)rect_ callback:(void(^)(NSString * _Nullable))callback_;
-(void)onDocumentSize:(int)width_ height:(int)height_ max_w:(int)max_width max_h:(int)max_height;
@end

NS_ASSUME_NONNULL_END
