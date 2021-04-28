//
//  WhiteboardControllerDelegate.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteboardControllerDelegate <NSObject>

-(void)onOpenCamera:(CGRect)rect_;
-(void)onOpenAlbum:(CGRect)rect_;
-(void)onOpeniCloud:(CGRect)rect_;

@end

NS_ASSUME_NONNULL_END
