//
//  LATPenToolbar.m
//  WhiteboardTest
//
//  Created by mac zhang on 2021/5/16.
//

#import "LATPenToolbar.h"
#import "LATToolbarColorButton.h"
#import "LATSizeSelectionToolbar.h"

@interface LATPenToolbar()
{
    NSArray * normalColorArray;
    NSArray * markColorArray;
    NSArray * currentColorArray;
}
@end

@implementation LATPenToolbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.multiSelectAllowed = YES;
        
        [self appendButtonsForImages:@[@"PenIcon",@"markIcon"]];
        
        LATToolbarColorButton * sizeEntry = [[LATToolbarColorButton alloc] init];
        sizeEntry.color = UIColor.blackColor;
        sizeEntry.scale = 0.2;
        [self appendButton:sizeEntry];
        
        normalColorArray = @[@"#FF000000",@"#FF1F9F8C",@"#FFF44336",@"#FFFFFFFF",@"#FFFFC000",@"#FF0086D0"];
        markColorArray = @[@"#FFFF5252",
                           @"#FF1ECAB1",
                           @"#FFFFC000",
                           @"#FF0BA8FF",
                           @"#FFF921D6",
                           @"#FF7CDA14"
        
        ];
        //@"#FF7CDA14"
        NSArray * colorbuttons = [super createColorGroupByColor:normalColorArray];
        
        [self appendButtons:colorbuttons];
        currentColorArray = normalColorArray;
    }
    return self;
}

-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
    LATInputConfig * penConfig = [self.barDelegate getInputConfigByMode:LATToolbarInputPencil];
    switch(index)
    {
        case 0:
            penConfig.penType = LATPenStyleNormal;
            break;
        case 1:
            penConfig.penType = LATPenStyleMark;
            break;
        case 2:
            [self.barDelegate onMenuEntryTaped:LATToolbarMenuPenSize];
            [self updateSelection];
            return;
        default:
        {
            NSString * color = currentColorArray[index -3];
            penConfig.color = color;
        }
            break;
    }
    [self.barDelegate sendInputConfig:LATToolbarInputPencil];
    [self updateSelection];
}
-(void)updateSelection
{
    LATInputConfig * penConfig = [self.barDelegate getInputConfigByMode:LATToolbarInputPencil];
    switch(penConfig.penType)
    {
        case LATPenStyleNormal:
            [self selectButtonAtIndex:0];
            [self deselectButtonAtIndex:1];
            break;
        case LATPenStyleMark:
            [self selectButtonAtIndex:1];
            [self deselectButtonAtIndex:0];
            break;
    }
    LATToolbarColorButton * sizeButton = self.buttons[2];
    sizeButton.scale = penConfig.size/10.f;
    if([self.barDelegate isViewHidden:[LATSizeSelectionToolbar class]])
    {
        [self deselectButtonAtIndex:2];
    }
    else
    {
        [self selectButtonAtIndex:2];
    }
    for(int i = 3;i < self.buttons.count;i ++)
    {
        LATToolbarColorButton * colorButton = self.buttons[i];
        
        NSString * colorString = [self convertColorToString:colorButton.color];
        NSLog(@"compare :%@ %@",colorString,penConfig.color);
        if([colorString caseInsensitiveCompare:penConfig.color])
        {
            [self deselectButtonAtIndex:i];
        }
        else
        {
            [self selectButtonAtIndex:i];
        }
    }
    [self setNeedsDisplay];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath compare:@"penType"] == NSOrderedSame)
    {
        if([change[@"new"] intValue] == LATPenStyleNormal)
        {
            currentColorArray = normalColorArray;
        }
        else
        if([change[@"new"] intValue] == LATPenStyleMark)
        {
            currentColorArray = markColorArray;
        }
        for(int i = 3;i < self.buttons.count ; i ++)
        {
            LATToolbarColorButton * btn = self.buttons[i];
            btn.color = [self convertStringToUIColor:currentColorArray[i-3]];
            [btn setNeedsDisplay];
        }
    }
    else if([keyPath compare:@"size"] == NSOrderedSame)
    {
        LATToolbarColorButton * sizeButton = self.buttons[2];
        sizeButton.scale = [change[@"new"] intValue]/10.f;
        if([self.barDelegate isViewHidden:[LATSizeSelectionToolbar class]])
        {
            [self deselectButtonAtIndex:2];
        }
        else
        {
            [self selectButtonAtIndex:2];
        }
        [sizeButton setNeedsDisplay];
    }
}
@end
