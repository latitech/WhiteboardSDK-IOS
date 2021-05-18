//
//  WBPageInfoCell.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/29.
//

#import "LATPageInfoCell.h"
#import <LATWhiteboard/LATWhiteboard.h>

@implementation LATPageInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)newPageAction:(UIButton *)sender {
    [[LATWhiteboardControl instance] insertBoardPage:self.pageInfo.pageId];
}
- (IBAction)deletePageAction:(id)sender {
    [[LATWhiteboardControl instance] deleteBoardPage:self.pageInfo.pageId];
}
@end
