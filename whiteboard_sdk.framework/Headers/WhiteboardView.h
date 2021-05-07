//
//  WhiteboardView.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/20.
//

#import <GLKit/GLKit.h>

#import "WhiteboardControl.h"
#import "WhiteboardUIDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteboardView : GLKViewController <GLKViewControllerDelegate,UIImagePickerControllerDelegate,WhiteboardDelegate,UIDocumentPickerDelegate,WhiteboardUIDelegate>

-(bool)initRender:(CGSize)size;

-(void)setDirty;


-(void)presentViewController:(UIViewController *)controller_;

@end

NS_ASSUME_NONNULL_END
