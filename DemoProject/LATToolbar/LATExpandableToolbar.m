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

typedef NS_ENUM(NSInteger,LATToolbarEventName)
{
    LATToolbarEventPencil,
    LATToolbarEventErase,
    LATToolbarEventLaser,
    LATToolbarEventSelect,
    LATToolbarEventGeometry,
    LATToolbarEventFile,
};
typedef NS_ENUM(NSInteger,LATToolbarStatus)
{
    LATToolbarStatusShowNothing,
    LATToolbarStatusShowPencil,
    LATToolbarStatusShowPencilDetail,
    LATToolbarStatusShowErase,
    LATToolbarStatusShowEraseDetail,
    LATToolbarStatusShowLaser,
    LATToolbarStatusShowGeometry,
    LATToolbarStatusShowGeometrySimpleDetail,
    LATToolbarStatusShowGeometryComplexDetail,
    LATToolbarStatusShowSelection
};

@interface LATExpandableToolbar()
{
    
    LATInputConfig * penConfig;
    LATInputConfig * eraserConfig;
    LATInputConfig * selectConfig;
    LATInputConfig * geometryConfig;
    LATInputConfig * laserConfig;
    
    LATSelectResourceViewController * resourceView;
    
    
    LATToolbarStatus status;
    
    
    LATPrimaryToolbar * primaryBar;
    LATPenToolbar * penBar;
    LATEraseToolbar * eraseBar;
    LATLaserToolbar * laserBar;
    LATGeometryToolbar * geometryBar;
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
        self.alignment = UIStackViewAlignmentFill;
        self.spacing = 10;

        self.backgroundColor = UIColor.blueColor;
        
        primaryBar = [[NSBundle bundleForClass:[LATPrimaryToolbar class] ]  loadNibNamed:@"LATPrimaryToolbar" owner:self options:nil].firstObject;
        primaryBar.frame = CGRectMake(0, 0, primaryBar.frame.size.width, 40);
        
        penBar = [[NSBundle bundleForClass:[LATExpandableToolbar class] ] loadNibNamed:@"LATPenToolbar" owner:self options:nil].firstObject;
        penBar.frame = CGRectMake(0, 0, penBar.frame.size.width, 40);
        
        
        eraseBar = [[NSBundle bundleForClass:[LATExpandableToolbar class] ] loadNibNamed:@"LATEraseToolbar" owner:self options:nil].firstObject;
        eraseBar.frame = CGRectMake(0, 0, eraseBar.frame.size.width, 40);
        
        laserBar = [[NSBundle bundleForClass:[LATExpandableToolbar class] ] loadNibNamed:@"LATLaserToolbar" owner:self options:nil].firstObject;
        laserBar.frame = CGRectMake(0, 0, laserBar.frame.size.width, 40);
        
        geometryBar = [[NSBundle bundleForClass:[LATExpandableToolbar class] ] loadNibNamed:@"LATGeometryToolbar" owner:self options:nil].firstObject;
        geometryBar.frame = CGRectMake(0, 0, laserBar.frame.size.width, 40);
        
        [self addArrangedSubview:primaryBar];
        
        [self addArrangedSubview:penBar];
        
        
        
        [self addArrangedSubview:laserBar];
        
        [self addArrangedSubview:eraseBar];
        
        [self addArrangedSubview:geometryBar];
        
        penBar.hidden = YES;
        eraseBar.hidden = YES;
        laserBar.hidden = YES;
        geometryBar.hidden = YES;
        
        penConfig = [LATInputConfig instanceWithPen:@"#FF000000" thickness:2.0f];
        eraserConfig = [LATInputConfig instanceWithErase:5.0];
        selectConfig = [LATInputConfig instanceWithSelect];
        laserConfig = [LATInputConfig instanceWithLaser:LATLaserTypeHand];
        geometryConfig = [LATInputConfig instanceWithGeometry:LATGeometryTypeRectangle color:@"FF000000" thickness:2.0f];
        
        status = LATToolbarStatusShowNothing;
    
    }
    return self;
}


- (IBAction)ItemSelected:(UIBarButtonItem *)sender {
    NSLog(@"clicked %@",sender.title);
    NSString * mode = sender.title;
    if(mode == nil)
    {
        return;
    }
    if([mode isEqualToString:@"pen"])
    {
        [[LATWhiteboardControl instance] setInputMode:penConfig];
        
        [self processEvent:LATToolbarEventPencil];
        
    }
    else if([mode isEqualToString:@"eraser"])
    {
        [[LATWhiteboardControl instance] setInputMode:eraserConfig];
        [self processEvent:LATToolbarEventErase];
    }
    else if([mode isEqualToString:@"select"])
    {
        [[LATWhiteboardControl instance] setInputMode:selectConfig];
    }
    else if([mode isEqualToString:@"file"])
    {
//        if(resourceView == nil)
//        {
//            self.resourceView = [[LATSelectResourceViewController alloc] initWithNibName:@"LATSelectResourceViewController" bundle:[NSBundle bundleForClass:[LATPrimaryToolbar class]]];
////            resourceView.uiDelegate = self.delegate;
//        }
//        [self. presentViewController:resourceView];
//        [self.delegate createResourceView];
       
    }
    else if([mode isEqualToString:@"laser"])
    {
        [[LATWhiteboardControl instance] setInputMode:laserConfig];
        [self processEvent:LATToolbarEventLaser];
    }
    else if([mode isEqualToString:@"geometry"])
    {
        [[LATWhiteboardControl instance] setInputMode:geometryConfig];
        [self processEvent:LATToolbarEventGeometry];
    }
}

-(void)processEvent:(LATToolbarEventName)eventName_
{
   
    switch(eventName_)
    {
        case LATToolbarEventPencil:
        {
            if(status != LATToolbarStatusShowPencil)
            {
                status = LATToolbarStatusShowPencil;
            }
            else
            {
                status = LATToolbarStatusShowNothing;
            }
        }
            break;
        case LATToolbarEventErase:
        {
            if(status != LATToolbarStatusShowErase)
            {
                status = LATToolbarStatusShowErase;
            }
            else
            {
                status = LATToolbarStatusShowNothing;
            }
        }
            break;
        case LATToolbarEventLaser:
            if(status != LATToolbarStatusShowLaser)
            {
                status = LATToolbarStatusShowLaser;
            }
            else
            {
                status = LATToolbarStatusShowNothing;
            }
            break;
        case LATToolbarEventGeometry:
            if(status != LATToolbarEventGeometry)
            {
                status = LATToolbarStatusShowGeometry;
            }
            else
                status = LATToolbarStatusShowNothing;
    }
    [self refreshToolbar];
}

-(void)refreshToolbar
{
    switch(status)
    {
        case LATToolbarStatusShowPencil:
        {
            [self showSubMenu:[LATPenToolbar class]];
        }
            break;
        case LATToolbarStatusShowErase:
        {
            [self showSubMenu:[LATEraseToolbar class]];
        }
            break;
        case LATToolbarStatusShowLaser:
        {
            [self showSubMenu:[LATLaserToolbar class]];
        }
            break;
        case LATToolbarStatusShowGeometry:
            [self showSubMenu:[LATGeometryToolbar class]];
            break;
             
        case LATToolbarStatusShowNothing:
            [self hideAllSubMenus];
            
    }
}

-(void)showSubMenu:(Class)viewType
{
    if(self.arrangedSubviews.count > 1)
    {
        for(int i = 1; i < self.arrangedSubviews.count ; i ++)
        {
            UIView * view = self.arrangedSubviews[i];
            if([view isKindOfClass:viewType])
            {
                NSLog(@"frame:%dx%d",view.frame.size.width,view.frame.size.height);
                view.hidden = NO;
            }
            else
                self.arrangedSubviews[i].hidden = YES;
        }
    }
    [self layoutSubviews];
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
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth  relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:400];
    
    [parent_ addConstraints:[NSArray arrayWithObjects:barTop,barRight,width,nil]];
}

- (IBAction)changeEraseSizeAction:(UIBarButtonItem *)sender {
    
    NSLog(@"erase %@ clicked",sender.title);
}
@end
