//
//  WhiteboardFloatingMenu.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/27.
//

#import <UIKit/UIKit.h>
#import <LATWhiteboard/LATWhiteboard.h>


NS_ASSUME_NONNULL_BEGIN

@interface LATFloatingMenu : UIToolbar <UIToolbarDelegate>

@property (weak,nonatomic) id<LATUIDelegate> delegate;

-(void)onWidgetActived:(LATActiveWidgetInfo *)widgetInfo_;
-(void)layoutMenu:(UIView *)parent;

@end

NS_ASSUME_NONNULL_END
