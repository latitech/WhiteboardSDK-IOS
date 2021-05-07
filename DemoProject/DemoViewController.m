//
//  ViewController.m
//  sdk_demo
//
//  Created by mac on 2021/4/22.
//

#import "DemoViewController.h"
#import <AVFoundation/AVFoundation.h>




@interface DemoViewController ()
{
    NSString * appId;
    NSString * roomId;
    NSString * userId;
    NSString * token;
}
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIStoryboard * board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TestViewController * testVC = [board instantiateViewControllerWithIdentifier:@"TestViewId"];
//
//    testVC.control = self.control;
//    [self addChildViewController:testVC];
//    testVC.view.frame = CGRectMake(10, 40, 36*7, 32);
//    [self.view addSubview:testVC.view];
//    [testVC didMoveToParentViewController:self];
    
    [self joinRoom];
}

-(void)joinRoom
{
    WBJoinInfo * joinInfo = [[WBJoinInfo alloc] initWithParam:appId room:roomId user:userId  token:token];
    WBRoomMember * member = [[WBRoomMember alloc] initWithParams:userId session:NULL role:6 name:NULL avatar:NULL];
    [[WhiteboardControl instance] joinRoom:joinInfo member:member];
}
                     
                     
- (void)initConnectionInfo:(NSString *)appId_ roomId:(NSString *)roomId_ userId:(NSString *)userId_ token:(NSString *)token_ { 
    appId = appId_;
    roomId = roomId_;
    userId = userId_;
    token = token_;
}

@end
