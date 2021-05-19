//
//  LATExpanableToolbar.m
//  WhiteboardTest
//
//  Created by mac zhang on 2021/5/16.
//

#import "LATExpandableToolbar.h"
#import "LATPrimaryToolbar.h"
#import "LATSelectResourceViewController.h"
#import "LATPenToolbar.h"
#import <LATWhiteboard/LATWhiteboard.h>
#import "LATEraseToolbar.h"
#import "LATLaserToolbar.h"
#import "LATGeometryToolbar.h"
#import "LATToolbarColorButton.h"
#import "LATSizeSelectionToolbar.h"
#import "LATColorToolbar.h"
#import "LATSubjectToolbar.h"


typedef NS_ENUM(NSInteger,LATToolbarStatus)
{
    LATToolbarStatusShowNothing,
    LATToolbarStatusShowPencil,
    LATToolbarStatusShowPencilDetail,
    LATToolbarStatusShowErase,
    LATToolbarStatusShowEraseDetail,
    LATToolbarStatusShowLaser,
    LATToolbarStatusShowGeometry,
    LATToolbarStatusShowGeometrySizeSelect,
    LATToolbarStatusShowGeometryColorSelect,
    LATToolbarStatusShowGeometrySubjectDetail,
    LATToolbarStatusShowSelection
};

@interface LATExpandableToolbar()
{
    
    LATInputConfig * penConfig;
    LATInputConfig * eraserConfig;
    LATInputConfig * selectConfig;
    LATInputConfig * geometryConfig;
    LATInputConfig * laserConfig;
    
    LATInputConfig * currentInputConfig;
    LATToolbarStatus status;
    LATGeometryToolbar * geometryBar;
    LATPenToolbar * penBar;
    LATSizeSelectionToolbar * sizeBar;
    
    LATSelectResourceViewController * resourceVC;
}
@end

@implementation LATExpandableToolbar


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
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFillProportionally;
        self.alignment = UIStackViewAlignmentCenter;
        self.spacing = 5;
        
        
//        self.backgroundColor = UIColor.blueColor;
        
        [self addToolbar:[[LATPrimaryToolbar alloc] initWithFrame:CGRectMake(0, 0, 280, 44)]];
            
        penBar = (LATPenToolbar *)[self addToolbar:[[LATPenToolbar alloc] initWithFrame:CGRectMake(0, 0, 460 ,44)]];
        
        [self addToolbar:[[LATEraseToolbar alloc] initWithFrame:CGRectMake(0, 0, 240, 44)]];
        
        [self addToolbar:[[LATLaserToolbar alloc] initWithFrame:CGRectMake(0, 0, 198, 44)]];
        
        
        geometryBar = (LATGeometryToolbar *)[self addToolbar:[[LATGeometryToolbar alloc] initWithFrame:CGRectMake(0, 0,280, 44)]];
        
        sizeBar = (LATSizeSelectionToolbar *)[self addToolbar:[[LATSizeSelectionToolbar alloc] initWithFrame:CGRectMake(0, 0, 180, 44 )]];
        
        [self addToolbar:[[LATColorToolbar alloc] initWithFrame:CGRectMake(0, 0, 308, 44)]];
        
        
        penConfig = [LATInputConfig instanceWithPen:@"#FF000000" thickness:2.0f];
        eraserConfig = [LATInputConfig instanceWithErase:40.0];
        selectConfig = [LATInputConfig instanceWithSelect];
        laserConfig = [LATInputConfig instanceWithLaser:LATLaserTypeHand];
        geometryConfig = [LATInputConfig instanceWithGeometry:LATGeometryTypeRectangle color:@"FF000000" thickness:4.0f];
        
        status = LATToolbarStatusShowNothing;
        
        currentInputConfig = penConfig;
        
        [penConfig addObserver:penBar forKeyPath:NSStringFromSelector(@selector(size)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [penConfig addObserver:penBar forKeyPath:NSStringFromSelector(@selector(penType)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [penConfig addObserver:sizeBar forKeyPath:NSStringFromSelector(@selector(penType)) options:NSKeyValueObservingOptionNew context:nil];
        [geometryConfig addObserver:geometryBar forKeyPath:NSStringFromSelector(@selector(size)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [geometryConfig addObserver:geometryBar forKeyPath:NSStringFromSelector(@selector(color)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        
        [self refreshToolbar];
        
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview == nil)
    {
        [penConfig removeObserver:penBar forKeyPath:NSStringFromSelector(@selector(size))];
        [penConfig removeObserver:penBar forKeyPath:NSStringFromSelector(@selector(penType))];
        
        [geometryConfig removeObserver:geometryBar forKeyPath:NSStringFromSelector(@selector(size))];
        [geometryConfig removeObserver:geometryBar forKeyPath:NSStringFromSelector(@selector(color))];
    }
}
-(LATBaseToolbar *)addToolbar:(LATBaseToolbar *)bar
{
    bar.hidden = NO;
    bar.layer.cornerRadius = 10;
    bar.layer.masksToBounds = YES;
    bar.barDelegate = self;
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeWidth  relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bar.frame.size.width];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bar.frame.size.height];
    [bar addConstraints:@[width,height]];
    
    
    [self addArrangedSubview:bar];
    
    return bar;
}

-(LATBaseToolbar *)loadToolbarFromNib:(NSString *)nibName owner:(id)target
{
    LATBaseToolbar *bar  = [[NSBundle bundleForClass:[LATPrimaryToolbar class] ]  loadNibNamed:nibName owner:target options:nil].firstObject;
    bar.hidden = NO;
    bar.layer.cornerRadius = 10;
    bar.layer.masksToBounds = YES;
    bar.barDelegate = self;
    
    [self addArrangedSubview:bar];
    return bar;
}

-(void)refreshToolbar
{
    switch(status)
    {
        case LATToolbarStatusShowPencil:
        {
            [self showSubMenu:@[[LATPenToolbar class]]];
        }
            break;
        case LATToolbarStatusShowPencilDetail:
        {
            [self showSubMenu:@[[LATPenToolbar class],[LATSizeSelectionToolbar class]]];
        }
            break;
        case LATToolbarStatusShowErase:
        {
            [self showSubMenu:@[[LATEraseToolbar class]]];
        }
            break;
        case LATToolbarStatusShowLaser:
        {
            [self showSubMenu:@[[LATLaserToolbar class]]];
        }
            break;
        case LATToolbarStatusShowGeometry:
            [self showSubMenu:@[[LATGeometryToolbar class]]];
            break;
        case LATToolbarStatusShowGeometrySizeSelect:
            [self showSubMenu:@[[LATGeometryToolbar class],[LATSizeSelectionToolbar class]]];
            break;
        case LATToolbarStatusShowGeometryColorSelect:
            [self showSubMenu:@[[LATGeometryToolbar class],[LATColorToolbar class]]];
            break;
        case LATToolbarStatusShowGeometrySubjectDetail:
            [self showSubMenu:@[[LATGeometryToolbar class],[LATSubjectToolbar class]]];
            break;
        case LATToolbarStatusShowNothing:
            [self showSubMenu:@[[LATPrimaryToolbar class]]];
            break;
            
    }
}

-(void)showSubMenu:(NSArray<Class> *)views
{
    if(self.arrangedSubviews.count > 1)
    {
        for(int i = 1; i < self.arrangedSubviews.count ; i ++)
        {
            LATBaseToolbar * toolbar = (LATBaseToolbar *)self.arrangedSubviews[i];
            if([views containsObject:[toolbar class]])
            {
                toolbar.hidden = NO;
                
                [toolbar updateSelection];
            }
            else
                toolbar.hidden = YES;
        }
    }
    [self layoutSubviews];
}
-(UIView *)getSubviewByType:(Class)type_
{
    for(int i = 0; i < self.arrangedSubviews.count ; i ++)
    {
        
        if([self.arrangedSubviews[i] isKindOfClass:type_])
        {
            return self.arrangedSubviews[i];
        }
        
    }
    return nil;
}
-(void)hideAllSubMenus
{
    if(self.arrangedSubviews.count > 1)
    {
        for(int i = 1; i < self.arrangedSubviews.count ; i ++)
        {
            self.arrangedSubviews[i].hidden = YES;
        }
    }
}
-(void)addConstraintToParent:(UIView *)parent_
{
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLayoutConstraint *barTop = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent_ attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    NSLayoutConstraint *barRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:parent_ attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:-20];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth  relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:500];
    
    [parent_ addConstraints:[NSArray arrayWithObjects:barTop,barRight,width,nil]];
}


-(LATInputConfig *)getInputConfigByMode:(LATToolbarInputName)mode_
{
    switch(mode_)
    {
        case LATToolbarInputPencil:
            return penConfig;
        case LATToolbarInputErase:
            return eraserConfig;
        case LATToolbarInputSelect:
            return selectConfig;
        case LATToolbarInputGeometry:
            return geometryConfig;
        case LATToolbarInputLaser:
            return laserConfig;
        default:
            return nil;
    }
}


-(void)sendInputConfig:(LATToolbarInputName)mode_
{
    LATInputConfig * config = [self getInputConfigByMode:mode_];
    if(config)
    {
        currentInputConfig = config;
        [[LATWhiteboardControl instance] setInputMode:currentInputConfig];
    }
}

-(void)onMenuEntryTaped:(LATToolbarMenuKey)menu_
{
    switch(menu_)
    {
        case LATToolbarMenuGeometrySize:
        {
            if(status == LATToolbarStatusShowGeometrySizeSelect)
            {
                //hide it
                status = LATToolbarStatusShowGeometry;
            }
            else
            {
                status = LATToolbarStatusShowGeometrySizeSelect;
            }
        }
            break;
        case LATToolbarMenuGeometryColor:
        {
            if(status == LATToolbarStatusShowGeometryColorSelect)
            {
                //hide it
                
                status = LATToolbarStatusShowGeometry;
            }
            else
            {
                status = LATToolbarStatusShowGeometryColorSelect;
            }
        }
            break;
        case LATToolbarMenuGeometryMath:
        case LATToolbarMenuGeometryPhysics:
        case LATToolbarMenuGeometryChemetry:
        {
            if(status == LATToolbarStatusShowGeometrySubjectDetail)
            {
                status = LATToolbarStatusShowGeometry;
            }
            else
            {
                status = LATToolbarStatusShowGeometrySubjectDetail;
            }
        }
            break;
        case LATToolbarMenuPenSize:
        {
            if(status == LATToolbarStatusShowPencilDetail)
            {
                
                status = LATToolbarStatusShowPencil;
            }
            else
            {
                status = LATToolbarStatusShowPencilDetail;
            }
        }
            break;
    }
    [self refreshToolbar];
}

-(void)switchInputMode:(LATToolbarInputName)mode_
{
    switch(mode_)
    {
        case LATToolbarInputPencil:
            if(status == LATToolbarStatusShowPencil)
                status = LATToolbarStatusShowNothing;
            else
                status = LATToolbarStatusShowPencil;
            break;
        case LATToolbarInputSelect:
            status = LATToolbarStatusShowNothing;
            break;
        case LATToolbarInputGeometry:
            if(status == LATToolbarStatusShowGeometry||
               status == LATToolbarStatusShowGeometrySizeSelect||
               status == LATToolbarStatusShowGeometryColorSelect ||
               status == LATToolbarStatusShowGeometrySubjectDetail)
            {
                status = LATToolbarStatusShowNothing;
            }
            else
                status = LATToolbarStatusShowGeometry;
            break;
        case LATToolbarInputErase:
            if(status == LATToolbarStatusShowErase)
            {
                status = LATToolbarStatusShowNothing;
            }
            else
                status = LATToolbarStatusShowErase;
            
            break;
        case LATToolbarInputLaser:
            if(status == LATToolbarStatusShowLaser)
            {
                status = LATToolbarStatusShowNothing;
            }
            else
                status = LATToolbarStatusShowLaser;
            break;
        case LATToolbarInputFile:
        {
            status = LATToolbarStatusShowNothing;
            [self popSelectResourceView];
        }
            break;
    }
    [self refreshToolbar];
    [self sendInputConfig:mode_];
}
-(BOOL)isViewHidden:(Class)view_
{
    UIView * target = [self getSubviewByType:view_];
    if(target)
    {
        return target.hidden;
    }
    return NO;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([object isEqual:penConfig])
    {
        NSLog(@"new size:%.2f\n",penConfig.size);
        NSLog(@"changed:%@",change);
    }
}
-(LATInputConfig *)getActiveInputConfig
{
    return currentInputConfig;
}
    
-(void)popSelectResourceView
{
    if(resourceVC == nil)
    {
        resourceVC = [[LATSelectResourceViewController alloc] initWithNibName:@"LATSelectResourceViewController" bundle:[NSBundle bundleForClass:[LATSelectResourceViewController class]]];
        resourceVC.uiDelegate = self.uiDelegate;
    }
    [self.uiDelegate presentViewController:resourceVC];
    
    
}
@end
