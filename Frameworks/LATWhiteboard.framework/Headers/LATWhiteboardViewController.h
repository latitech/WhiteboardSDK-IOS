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
typedef NS_ENUM(NSInteger,LATViewHorizonAlign)
{
    //水平方向居中对齐
    LATViewHorizonAlignCenter,
    //水平方向左对齐
    LATViewHorizonAlignLeft,
    //水平方向右对齐
    LATViewHorizonAlignRight
};
typedef NS_ENUM(NSInteger,LATViewVerticalAlign)
{
    //垂直方向居中对齐
    LATViewVerticalAlignCenter,
    //垂直方向顶部对齐
    LATViewVerticalAlignTop,
    //垂直方向底部对齐
    LATViewVerticalAlignBottom
};

@interface LATWhiteboardViewController : GLKViewController <GLKViewControllerDelegate,LATUIDelegate,LATWhiteboardDelegate>


/**
 lockRatio表示是否根据内容的比例来锁定屏幕，适配的规则由horAlign和verAlign来指定。默认需要适配。
 */
@property (nonatomic,assign) BOOL lockRatio;

/**
    view在autoScale为YES的情况下水平对齐设定，默认为居中
 */
@property (nonatomic,assign) LATViewHorizonAlign horAlign;

/**
    view在autoScale为YES的情况下垂直对齐设定，默认值为居中
 */
@property (nonatomic,assign) LATViewVerticalAlign verAlign;

-(bool)initRender:(CGSize)size;

-(void)setDirty;


-(void)presentViewController:(UIViewController *)controller_;



-(void)initializeWhiteboard;
-(void)closeWhiteboard;

@end

NS_ASSUME_NONNULL_END
