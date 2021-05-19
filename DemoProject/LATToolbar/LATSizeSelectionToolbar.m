//
//  LATPenSizeToolbar.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/18.
//

#import "LATSizeSelectionToolbar.h"
#import "LATToolbarColorButton.h"
@interface LATSizeSelectionToolbar()
{
    NSArray * normalPenSizeArray;
    NSArray * markPenSizeArray;
    NSArray * geometrySizeArray;
    NSArray * sizeArray;
}
@end
@implementation LATSizeSelectionToolbar

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
        normalPenSizeArray = @[@(0.1f),@(0.15f),@(0.25f),@(0.4)];
        markPenSizeArray = @[@(0.2f),@(0.4f),@(0.6f),@(1.0)];
        geometrySizeArray = @[@(0.05f),@(0.1f),@(0.2f),@(0.4)];
        NSMutableArray *buttons = [NSMutableArray new];
        for(NSNumber * size in normalPenSizeArray)
        {
            LATToolbarColorButton * button = [LATToolbarColorButton buttonWithType:UIButtonTypeRoundedRect];
            button.color = UIColor.blackColor;
            button.scale = [size floatValue];
            [buttons addObject:button];
        }
        [self appendButtons:buttons];
    }
    return self;
}

-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
     LATInputConfig * config = [self.barDelegate getActiveInputConfig];

    
    NSNumber * value = sizeArray[index];
    config.size = [value floatValue] * 25;
    switch(config.mode)
    {
        case LATInputModePen:
            [self.barDelegate sendInputConfig:LATToolbarInputPencil];
            break;
        case LATInputModeGeometry:
            [self.barDelegate sendInputConfig:LATToolbarInputGeometry];
            break;
        default:
            break;
    }
    
}
-(void)updateSelection
{
    LATInputConfig * config = [self.barDelegate getActiveInputConfig];
    switch(config.mode)
    {
        case LATInputModePen:
        {
            if(config.penType == LATPenStyleNormal)
            {
                sizeArray = normalPenSizeArray;
            }
            else if(config.penType == LATPenStyleMark)
            {
                sizeArray = markPenSizeArray;
            }
        }
            break;
        case LATInputModeGeometry:
        {
            sizeArray = geometrySizeArray;
        }
            break;
        default:
            break;
    }
    for(int i = 0;i < self.buttons.count; i ++)
    {
        LATToolbarColorButton * btn = self.buttons[i];
        btn.scale = [sizeArray[i] floatValue];
        [btn setNeedsDisplay];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateSelection];
}
@end
