//
//  WB_ScreenShotsDelegate.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WBScreenShotsDelegate <NSObject>

-(void)done:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
