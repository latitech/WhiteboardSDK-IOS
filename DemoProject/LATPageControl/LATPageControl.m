//
//  WhiteboardPageControl.m
//  whiteboard_sdk
//
//  Created by mac zhang on 2021/4/26.
//

#import "LATPageControl.h"
#import <LATWhiteboard/LATWhiteboard.h>
#import "LATPageListView.h"

@interface LATPageControl()
{
    UIBarButtonItem * backButton;
    UIBarButtonItem * allPageBtn;
    UIBarButtonItem * prevPageBtn;
    UIBarButtonItem * nextPageBtn;
    UIBarButtonItem * currentPageInfo;
 
    NSInteger currentPageNumber;
    NSInteger maxPageNumber;
    BOOL isPageListShown;

}
@property (nonatomic,retain) LATPageListView * pageListView;
@end
@implementation LATPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    isPageListShown = NO;
    [[LATWhiteboardControl instance] addListener:self];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        isPageListShown = NO;
//        [[WhiteboardControl instance] addListener:self];
    }
    return self;
}
-(void)layoutMenu:(UIView *)parent
{    
    self.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *pageHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36];
    NSLayoutConstraint *pageWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:220];
    
    NSLayoutConstraint *pageBottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    NSLayoutConstraint *pageLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [parent addConstraints:[NSArray arrayWithObjects:pageWidth,pageHeight,pageLeft,pageBottom,nil]];
    
}
- (IBAction)listAllPage:(id)sender {
    if(isPageListShown)
    {
        _pageListView = [[LATPageListView alloc] initWithNibName:@"LATPageListView" bundle:[NSBundle bundleForClass:[LATPageListView class]]];
        
        [self.uiDelegate addChildView:self.pageListView.view];
        [self.pageListView setContraint:[self superview] pageCtrlView:self];
        
//        [self.uiDelegate hidePageListView];
    }
    else
    {
        [self.pageListView.view removeFromSuperview];
    }
    
    isPageListShown = !isPageListShown;
}
- (IBAction)prevPage:(id)sender {
    if(currentPageNumber > 1)
    {
        [[LATWhiteboardControl instance] switchToPageNumber:currentPageNumber -1];
    }
}
- (IBAction)nextPage:(id)sender {
    [[LATWhiteboardControl instance] switchToPageNumber:currentPageNumber +1];
}

-(void)updatePageInfo:(NSInteger)currentPageNo_ max:(NSInteger)maxPageNo_
{
    currentPageNumber = currentPageNo_;
    maxPageNumber = maxPageNo_;
    NSString * title = [NSString stringWithFormat:@"%ld/%ld",(long)currentPageNo_,(long)maxPageNo_];
    if(currentPageNumber == maxPageNumber)
    {
        [_nextPageCtrl setImage:[UIImage imageNamed:@"newPage" inBundle:[NSBundle bundleForClass:[LATPageControl class]] compatibleWithTraitCollection:nil]];
    }
    else
    {
        [_nextPageCtrl setImage:[UIImage imageNamed:@"nextPage" inBundle:[NSBundle bundleForClass:[LATPageControl class]] compatibleWithTraitCollection:nil]];
    }
    [_pageInfoCtrl setTitle:title];
}

-(void)onCurrentBoardPageChanged:(LATPageInfo *)page_
{
    [self updatePageInfo:page_.pageNumber max:[[LATWhiteboardControl instance] getMaxPageNumber]];
}
@end
