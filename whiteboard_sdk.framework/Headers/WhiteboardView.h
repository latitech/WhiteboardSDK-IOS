//
//  WhiteboardView.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/20.
//

#import <GLKit/GLKit.h>

#import "WhiteboardControl.h"
#import "WhiteboardControllerDelegate.h"
#import "WhiteboardUIDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteboardView : GLKViewController <GLKViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WhiteboardDelegate,WhiteboardControllerDelegate,UIDocumentPickerDelegate,WhiteboardUIDelegate>

@property(atomic,retain,readonly) WhiteboardControl * control;

-(bool)initReader:(CGSize)size;

-(void)setDirty;

-(void)onOpenCamera:(CGRect)rect_;
-(void)onOpenAlbum:(CGRect)rect_;
-(void)onOpeniCloud:(CGRect)rect_;


-(void)changeInputConfig:(WBInputConfig *)inputConfig_;

-(void)changeCurrentPageNumber:(NSInteger)pageNo_;

@end

NS_ASSUME_NONNULL_END
