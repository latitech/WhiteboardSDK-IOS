//
//  ViewController.m
//  sdk_demo
//
//  Created by mac on 2021/4/22.
//

#import "DemoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LATSelectResourceView/LATSelectResourceViewController.h"
#import "LATPageControl/LATPageControl.h"
#import "LATPageThumbnailsView/LATPageListView.h"
#import "LATWidgetMenu/LATFloatingMenu.h"
#import "LATToolbar/LATExpandableToolbar.h"





@interface DemoViewController ()
{
    NSString * appId;
    NSString * roomId;
    NSString * userId;
    NSString * token;
    UICollectionViewController * menuBar;
    LATPageControl * pageControl;
    LATFloatingMenu * floatingMenu;
    LATPageListView * pageListView;
    LATExpandableToolbar * toolbar;
}
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle * bundle = [NSBundle mainBundle];
    
    
    
    //添加退出按钮
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 64, 64)];
    [button setImage:[UIImage imageNamed:@"logout" inBundle:[NSBundle bundleForClass:[LATWhiteboardControl class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [button setTintColor:UIColor.blackColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(onBackPressed) forControlEvents:UIControlEventTouchDown];
    
    //添加工具栏
    toolbar = [[LATExpandableToolbar alloc] init];
    [self.view addSubview:toolbar];
    [toolbar addConstraintToParent:self.view];
    
    //添加页导航
    pageControl = [[UINib nibWithNibName:@"LATPageControl" bundle:bundle] instantiateWithOwner:nil options:nil].firstObject;
    
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pageControl];
    [pageControl layoutMenu:self.view];
    
    pageControl.uiDelegate = self;
    
    //添加widget菜单
    floatingMenu = [[LATFloatingMenu alloc] init];
    floatingMenu.delegate = self;
   
    [self.view addSubview:floatingMenu];
    [floatingMenu layoutMenu:self.view];
    
    
    //进入房间
    [self joinRoom];
}


-(void)onBackPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)joinRoom
{
    LATJoinInfo * joinInfo = [[LATJoinInfo alloc] initWithParam:appId room:roomId user:userId  token:token];
    LATRoomMember * member = [[LATRoomMember alloc] initWithParams:userId session:nil role:6 name:nil avatar:nil];
    [[LATWhiteboardControl instance] joinRoom:joinInfo member:member];
}
                     
                     
- (void)initConnectionInfo:(NSString *)appId_ roomId:(NSString *)roomId_ userId:(NSString *)userId_ token:(NSString *)token_ { 
    appId = appId_;
    roomId = roomId_;
    userId = userId_;
    token = token_;
}

@end
