//
//  LATLaserToolbar.m
//  WhiteboardTest
//
//  Created by mac on 2021/5/19.
//

#import "LATLaserToolbar.h"

@implementation LATLaserToolbar

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
        [self appendButtonsForImages:@[@"laserHand",@"laserDot",@"laserWhiteArrow",@"laserBlackArrow"]];
        
    }
    return self;
}

-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
    LATInputConfig * laserConfig = [self.barDelegate getInputConfigByMode:LATToolbarInputLaser];
    switch(index)
    {
        case 0:
            laserConfig.penType = LATLaserTypeHand;
            break;
        case 1:
            laserConfig.penType = LATLaserTypeDot;
            break;
        case 2:
            laserConfig.penType = LATLasterTypeWhiteArrow;
            break;
        case 3:
            laserConfig.penType = LATLaserTypeBlackArrow;
            break;
        
    }
    [self.barDelegate sendInputConfig:LATToolbarInputLaser];
}
-(void)updateSelection
{
    LATInputConfig * laserConfig = [self.barDelegate getInputConfigByMode:LATToolbarInputLaser];
    
    switch(laserConfig.penType)
    {
        case LATLaserTypeHand:
        
            [self selectButtonAtIndex:0];
            break;
        case LATLaserTypeDot:
            [self selectButtonAtIndex:1];
            break;
        case LATLasterTypeWhiteArrow:
            [self selectButtonAtIndex:2];
            break;
        case LATLaserTypeBlackArrow:
            [self selectButtonAtIndex:3];
            break;
        default:
            break;
    }
}
@end
