//
//  WhiteboardFloatingMenu.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/27.
//

#import "LATFloatingMenu.h"
#import <LATWhiteboard/LATWhiteboard.h>




@interface LATFloatingMenu()
{
    LATActiveWidgetInfo * activeWidget;
    UIBarButtonItem * downloadBtn;
    UIBarButtonItem * deleteBtn;
    UIBarButtonItem * prevPageBtn;
    UIBarButtonItem * nextPageBtn;
    UIBarButtonItem * pageInfoLabel;
    
}
@end

@implementation LATFloatingMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        downloadBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download" inBundle:[NSBundle bundleForClass:[LATFloatingMenu class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(downloadAction)];
        [downloadBtn setTintColor:UIColor.darkGrayColor];
        deleteBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete" inBundle:[NSBundle bundleForClass:[LATFloatingMenu class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction)];
        [deleteBtn setTintColor:UIColor.darkGrayColor];
        prevPageBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prevPage" inBundle:[NSBundle bundleForClass:[LATFloatingMenu class]] compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(prevPageAction)];
        [prevPageBtn setTintColor:UIColor.darkGrayColor];
        
        UIImage * nextImage = [UIImage imageNamed:@"nextPage" inBundle:[NSBundle bundleForClass:[LATFloatingMenu class]] compatibleWithTraitCollection:nil];
        if(nextImage == nil)
        {
            NSLog(@"nextImage is nullptr in FloatingMenu");
        }
        else
        {
            NSLog(@"nextImage is not null in FloatingMenu");
        }
        nextPageBtn = [[UIBarButtonItem alloc] initWithImage:nextImage style:UIBarButtonItemStylePlain target:self action:@selector(nextPageAction)];
        [nextPageBtn setTintColor:UIColor.darkGrayColor];
        
        pageInfoLabel = [[UIBarButtonItem alloc] initWithTitle:@"1/2" style:UIBarButtonItemStylePlain target:self action:@selector(onPageInfoAction)];
        [pageInfoLabel setTintColor:UIColor.darkGrayColor];
        
//        UIBarButtonItem * widgetControl = [[UIBarButtonItem alloc] initWithTitle:@"widgetControl"  style:UIBarButtonItemStylePlain target:nil action:nil];
//        UIBarButtonItemGroup * group = [[UIBarButtonItemGroup alloc] initWithBarButtonItems:@[prevPageBtn,pageInfoLabel,nextPageBtn] representativeItem:widgetControl];
        
        [self setItems:@[prevPageBtn,pageInfoLabel,nextPageBtn,/*downloadBtn,*/deleteBtn]];
        
//        [self setItems:@[group,downloadBtn,deleteBtn]];
        [self setBackgroundColor:UIColor.blackColor];
        [self setBarTintColor:UIColor.whiteColor];
    }
    return self;
}

-(void)downloadAction
{
    
}
-(void)deleteAction
{
    [[LATWhiteboardControl instance] deleteFile:activeWidget.widgetId];
}
-(void)prevPageAction
{
    if(activeWidget&& activeWidget.currentPageNumber > 1)
    {
        [[LATWhiteboardControl instance] jumpFilePage:activeWidget.widgetId pageNo:activeWidget.currentPageNumber -1];
    }
}
-(void)nextPageAction
{
    if(activeWidget && activeWidget.currentPageNumber < activeWidget.pageCount)
    {
        [[LATWhiteboardControl instance] jumpFilePage:activeWidget.widgetId pageNo:activeWidget.currentPageNumber + 1];
       
    }
}
-(void)onPageInfoAction
{
    
}
-(void)layoutMenu:(UIView *)parent
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *pageHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36];
    NSLayoutConstraint *pageWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:260];
    
    NSLayoutConstraint *pageTop = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    NSLayoutConstraint *pageLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [parent addConstraints:[NSArray arrayWithObjects:pageWidth,pageHeight,pageLeft,pageTop,nil]];
    
    [self setHidden:YES];
}
-(void)onWidgetActived:(LATActiveWidgetInfo *)widgetInfo_
{
    activeWidget = widgetInfo_;
    if(activeWidget)
    {
        NSString * pageInfo = [NSString stringWithFormat:@"%d/%d",activeWidget.currentPageNumber,activeWidget.pageCount];
        pageInfoLabel.title = pageInfo;
        [self setHidden:NO];
    }
    else
    {
        [self setHidden:YES];
    }
}

@end
