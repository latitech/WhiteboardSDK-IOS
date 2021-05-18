//
//  WhiteboardPageControl.h
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import <UIKit/UIKit.h>

#import <LATWhiteboard/LATWhiteboard.h>

NS_ASSUME_NONNULL_BEGIN

@interface LATPageControl : UIToolbar <LATWhiteboardDelegate>

@property (nonatomic,weak) id<LATUIDelegate> uiDelegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pageListCtrl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevPageCtrl;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pageInfoCtrl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextPageCtrl;
-(void)updatePageInfo:(NSInteger)currentPageNo_ max:(NSInteger)maxPageNo_;

-(void)useContraint;
-(void)layoutMenu:(UIView *)parent;
-(void)onCurrentBoardPageChanged:(LATPageInfo *)page_;
@end

NS_ASSUME_NONNULL_END
