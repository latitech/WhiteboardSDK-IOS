//
//  LATBaseToolbar.h
//  WhiteboardTest
//
//  Created by mac on 2021/5/19.
//

#import <UIKit/UIKit.h>
#import "LATToolbarDelegate.h"
#import "MWButtonGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface LATBaseToolbar : MWButtonGroup <MWButtonGroupDelegate>

@property (nonatomic,weak) id<LATToolbarDelegate> barDelegate;

-(NSArray *)createColorGroupByColor:(NSArray *)colorArray;

-(NSString *)convertColorToString:(UIColor *)color_;
-(UIColor *)convertStringToUIColor:(NSString *)color_;
-(void)updateSelection;
-(LATToolbarInputName)getInputNameByInputMode:(LATInputMode)mode_;
@end

NS_ASSUME_NONNULL_END
