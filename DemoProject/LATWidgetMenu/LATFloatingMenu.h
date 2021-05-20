//
//  WhiteboardFloatingMenu.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/27.
//

#import <UIKit/UIKit.h>
#import <LATWhiteboard/LATWhiteboard.h>


NS_ASSUME_NONNULL_BEGIN

@interface LATFloatingMenu : UIStackView <LATWhiteboardDelegate>

@property (weak,nonatomic) id<LATUIDelegate> delegate;

-(void)onWidgetActive:(LATActiveWidgetInfo * _Nullable)widgetInfo_;
-(void)layoutMenu:(UIView *)parent;

@end

NS_ASSUME_NONNULL_END
