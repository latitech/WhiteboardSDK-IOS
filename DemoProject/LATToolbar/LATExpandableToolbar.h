//
//  LATExpanableToolbar.h
//  WhiteboardTest
//
//  Created by mac zhang on 2021/5/16.
//

#import <UIKit/UIKit.h>
#import "LATToolbarDelegate.h"



NS_ASSUME_NONNULL_BEGIN

@interface LATExpandableToolbar : UIStackView <LATToolbarDelegate>

@property (nonatomic,weak) id<LATUIDelegate> uiDelegate;

-(void)addConstraintToParent:(UIView *)parent_;
@end

NS_ASSUME_NONNULL_END
