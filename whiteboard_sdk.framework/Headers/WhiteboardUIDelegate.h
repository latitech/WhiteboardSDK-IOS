//
//  WhiteboardUIDelegate.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import <Foundation/Foundation.h>
#import "WBInputConfig.h"
#import "WBActiveWidgetInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteboardUIDelegate <NSObject>
-(void)presentViewController:(UIViewController *)controller_;
-(void)createResourceView;
@end

NS_ASSUME_NONNULL_END
