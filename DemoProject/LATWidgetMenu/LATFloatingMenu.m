//
//  WhiteboardFloatingMenu.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/27.
//

#import "LATFloatingMenu.h"
#import <LATWhiteboard/LATWhiteboard.h>

typedef NS_ENUM(NSInteger,LATFloatingMenuKey)
{
    LATFloatingMenuDownload,
    LATFloatingMenuDelete,
    LATFloatingMenuPrevBtn,
    LATFloatingMenuPageInfo,
    LATFloatingMenuNextPage,
};


@interface LATFloatingMenu()
{
    LATActiveWidgetInfo * activeWidget;
    UIButton * downloadBtn;
    UIButton * deleteBtn;
    UIButton * prevPageBtn;
    UIButton * nextPageBtn;
    UIButton * pageInfoLabel;
    
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
-(instancetype)init
{
    if(self = [super init])
    {
        self.axis = UILayoutConstraintAxisHorizontal;
        self.distribution = UIStackViewDistributionFillProportionally;
        self.alignment = UIStackViewAlignmentCenter;
        self.spacing = 5;
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        
        downloadBtn = [self createButtonByImageName:@"download"];
        [downloadBtn setTag:LATFloatingMenuDownload];
        downloadBtn.hidden = YES;
        
        
        deleteBtn = [self createButtonByImageName:@"delete"];
        [deleteBtn setTag:LATFloatingMenuDelete];
        
        prevPageBtn = [self createButtonByImageName:@"prevPage"];
        [prevPageBtn setTag:LATFloatingMenuPrevBtn];
       
        nextPageBtn = [self createButtonByImageName:@"nextPage"];
        [nextPageBtn setTag:LATFloatingMenuNextPage];
        
        pageInfoLabel = [self createButtonByTitle:@"1/2"];
        [pageInfoLabel setTag:LATFloatingMenuPageInfo];
        
        [self addArrangedSubview:downloadBtn];
        [self addArrangedSubview:deleteBtn];
        [self addArrangedSubview:prevPageBtn];
        [self addArrangedSubview:pageInfoLabel];
        [self addArrangedSubview:nextPageBtn];
        [self setBackgroundColor:UIColor.blackColor];
        [self setTintColor:UIColor.whiteColor];
        [[LATWhiteboardControl instance] addListener:self];
        self.hidden = YES;
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
    
    NSLayoutConstraint *pageTop = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    NSLayoutConstraint *pageLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [parent addConstraints:[NSArray arrayWithObjects:pageHeight,pageLeft,pageTop,nil]];
    
//    [self setHidden:YES];
}
-(void)onWidgetActive:(LATActiveWidgetInfo *)widgetInfo_
{
    activeWidget = widgetInfo_;
    if(activeWidget)
    {
        if(activeWidget.type == LATWidgetTypeFile)
        {
            prevPageBtn.hidden = NO;
            nextPageBtn.hidden = NO;
            pageInfoLabel.hidden = NO;
            
            NSString * pageInfo = [NSString stringWithFormat:@"%d/%d",activeWidget.currentPageNumber,activeWidget.pageCount];
            [pageInfoLabel setTitle:pageInfo forState:UIControlStateNormal];
            
            
        }
        else
        {

            prevPageBtn.hidden = YES;
            nextPageBtn.hidden = YES;
            pageInfoLabel.hidden = YES;
        }
        [self setHidden:NO];
    }
    else
    {
        [self setHidden:YES];
    }
}
-(UIButton *)createButtonByImageName:(NSString *)imageName
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
        [btn setImage:[UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[LATFloatingMenu class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(UIButton *)createButtonByTitle:(NSString *)title
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTintColor:UIColor.whiteColor];
    return btn;
}
-(void)onButtonPressed:(UIButton *)sender
{
    NSLog(@"button %ld is pressed",(long)sender.tag);
    switch(sender.tag)
    {
        case LATFloatingMenuPrevBtn:
            [self prevPageAction];
            break;
        case LATFloatingMenuNextPage:
            [self nextPageAction];
            break;
        case LATFloatingMenuDownload:
            [self downloadAction];
            break;
        case LATFloatingMenuDelete:
            [self deleteAction];
            break;
            
    }
}
@end
