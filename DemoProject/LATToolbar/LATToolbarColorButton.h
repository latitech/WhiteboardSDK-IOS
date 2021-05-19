//
//  LATPenColorElementView.h
//  WhiteboardTest
//
//  Created by mac on 2021/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATToolbarColorButton : UIButton
@property (retain,nonatomic) IBInspectable UIColor * color;
@property (assign,nonatomic) CGFloat scale;
@end

NS_ASSUME_NONNULL_END
