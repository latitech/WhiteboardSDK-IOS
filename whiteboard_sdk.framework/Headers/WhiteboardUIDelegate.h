//
//  WhiteboardUIDelegate.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WBInputConfig.h"
#import "WBActiveWidgetInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteboardUIDelegate <NSObject>
-(void)presentViewController:(UIViewController *)controller_;
-(void)appendSubView:(UIView *)view_;
-(void)removeSubView:(UIView *)view_;
-(void)createResourceView;
-(NSString *)snapShot:(CGRect)rect_;
@end

NS_ASSUME_NONNULL_END
