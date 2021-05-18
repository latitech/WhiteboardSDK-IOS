//
//  WBPageInfoCell.h
//  whiteboard_sdk
//
//  Created by mac on 2021/4/29.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <LATWhiteboard/LATWhiteboard.h>


NS_ASSUME_NONNULL_BEGIN

@interface LATPageInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet SDAnimatedImageView *thumbnails;
@property (weak, nonatomic) IBOutlet UILabel *pageNumber;

@property (nonatomic,retain) LATPageInfo * pageInfo;
@end

NS_ASSUME_NONNULL_END
