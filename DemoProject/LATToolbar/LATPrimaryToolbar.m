//
//  LATPrimaryToolbar.m
//  WhiteboardTest
//
//  Created by mac zhang on 2021/5/16.
//

#import "LATPrimaryToolbar.h"
#import <LATWhiteboard/LATWhiteboard.h>

#import "LATExpandableToolbar.h"

@interface LATPrimaryToolbar()
{

}
@end
@implementation LATPrimaryToolbar

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
        [self appendButtonsForImages:@[@"selectIcon",@"PenIcon",@"eraseIcon",@"geometryIcon",@"laserIcon",@"fileIcon"]];
        self.delegate = self;
    }
    return self;
}

-(void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index
{
    switch(index)
    {
        case 0:
            [self.barDelegate switchInputMode:LATToolbarInputSelect];
            break;
        case 1:
            [self.barDelegate switchInputMode:LATToolbarInputPencil];
            break;
        case 2:
            [self.barDelegate switchInputMode:LATToolbarInputErase];
            break;
        case 3:
            [self.barDelegate switchInputMode:LATToolbarInputGeometry];
            break;
        case 4:
            [self.barDelegate switchInputMode:LATToolbarInputLaser];
            break;
        case 5:
            //file
            [self.barDelegate switchInputMode:LATToolbarInputFile];
            break;
        default:
            break;
            
    }
}
-(void)updateSelection
{
    
}
@end
