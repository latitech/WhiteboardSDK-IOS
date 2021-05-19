//
//  LATColorToolbar.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/18.
//

#import "LATColorToolbar.h"
#import "LATToolbarColorButton.h"
@interface LATColorToolbar()
{
    NSArray * colorArray;
}
@end

@implementation LATColorToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        colorArray = @[@"#FF1f9f8c",@"#FFF44336",@"#FFFFFFFF",@"#FF582798",@"#FFffc000",@"#FF999999",@"#FF0086d0"];
        NSArray * colorButtons = [self createColorGroupByColor:colorArray];
        [self appendButtons:colorButtons];
    }
    return self;
}
- (IBAction)onColorSelected:(LATToolbarColorButton *)sender {
    
    LATInputConfig * config = [self.barDelegate getActiveInputConfig];
    if(config == nil)
        return;
    NSString * color = [self convertColorToString:sender.color];
    config.color = color;
    [self.barDelegate sendInputConfig:[self getInputNameByInputMode:config.mode]];
}
-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
    NSString * color = colorArray[index];
    LATInputConfig * config = [self.barDelegate getActiveInputConfig];
    config.color = color;
    [self.barDelegate sendInputConfig:[self getInputNameByInputMode:config.mode]];
}
-(void)updateSelection
{
    
}
@end
