//
//  WBPageCellHeader.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/29.
//

#import "LATPageCellHeader.h"
#import <LATWhiteboard/LATWhiteboard.h>

@implementation LATPageCellHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)newPageAction:(UIButton *)sender {
    [[LATWhiteboardControl instance] newBoardPage];
    
}

@end
