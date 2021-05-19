//
//  LATGeometryToolbar.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/17.
//

#import "LATGeometryToolbar.h"
#import "LATSizeSelectionToolbar.h"
#import "LATToolbarColorButton.h"
#import "LATColorToolbar.h"

@implementation LATGeometryToolbar
@synthesize barDelegate;
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
        LATToolbarColorButton * colorButton = [LATToolbarColorButton buttonWithType:UIButtonTypeRoundedRect];
        colorButton.color = UIColor.blackColor;
        colorButton.scale = 0.7;
        
        LATToolbarColorButton * sizeButton = [LATToolbarColorButton buttonWithType:UIButtonTypeRoundedRect];
        sizeButton.color = UIColor.blackColor;
        sizeButton.scale = 0.2;
        
        [self appendButtons:@[colorButton,sizeButton]];
        [self appendButtonsForImages:@[@"line",@"arrow",@"rectangle",@"circle"]];
        
//        [self appendButtonsForTitles:@[@"数学",@"物理",@"化学"]];
    }
    return self;
}
-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
    
    LATInputConfig * geometryConfig = [barDelegate getInputConfigByMode:LATToolbarInputGeometry];
    
    switch(index)
    {
        case 0:
            [barDelegate onMenuEntryTaped:LATToolbarMenuGeometryColor];
            return;
        case 1:
            [barDelegate onMenuEntryTaped:LATToolbarMenuGeometrySize];
            return;
        case 2:
            geometryConfig.geometryType = LATGeometryTypeLine;
            break;
        case 3:
            geometryConfig.geometryType = LATGeometryTypeArrow;
            break;
        case 4:
            geometryConfig.geometryType = LATGeometryTypeRectangle;
            break;
        case 5:
            geometryConfig.geometryType = LATGeometryTypeCircle;
            break;
        case 6:
            [barDelegate onMenuEntryTaped:LATToolbarMenuGeometryMath];
            break;
        case 7:
            [barDelegate onMenuEntryTaped:LATToolbarMenuGeometryPhysics];
            break;
        case 8:
            [barDelegate onMenuEntryTaped:LATToolbarMenuGeometryChemetry];
            break;
    }
    [barDelegate sendInputConfig:LATToolbarInputGeometry];
}
-(void)updateSelection
{
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath compare:@"color"] == NSOrderedSame)
    {
        NSString * colorString = change[@"new"];
        LATToolbarColorButton * button = self.buttons[0];
        button.color = [self convertStringToUIColor:colorString];
        [button setNeedsDisplay];
    }
    else if([keyPath compare:@"size"] == NSOrderedSame)
    {
        LATToolbarColorButton * sizeButton = self.buttons[1];
        sizeButton.scale = [change[@"new"] intValue]/10.f;
        if([self.barDelegate isViewHidden:[LATSizeSelectionToolbar class]])
        {
            [self deselectButtonAtIndex:1];
        }
        else
        {
            [self selectButtonAtIndex:1];
        }
        [sizeButton setNeedsDisplay];
    }
}
@end
