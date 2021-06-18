//
//  WhiteboardView.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/20.
//

#import <GLKit/GLKit.h>

#import "LATWhiteboardControl.h"

#import "LATUIDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATWhiteboardViewController : GLKViewController <GLKViewControllerDelegate,LATUIDelegate,LATWhiteboardDelegate>

-(bool)initRender:(CGSize)size;

-(void)setDirty;


-(void)presentViewController:(UIViewController *)controller_;



-(void)initializeWhiteboard;
-(void)closeWhiteboard;

@end

NS_ASSUME_NONNULL_END
