//
//  TestNavigatorController.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/28.
//

#import "TestNavigatorController.h"
#import "DemoViewController.h"

#define APP_ID @"fd3c029d48a64afeb5b46c24aedc2995"
#define USER_ID_FIRST @"test1"
#define ROOM_ID_FIRST @"4002a30317a4487db0fb1e1e0cf9401a"
#define TOKEN_FIRST @"b5b011f8f0dac3ea6daa3fe611a0f590"

#define USER_ID_SECOND  @"0585184c-b515-4533-b146-1d39379e7d9a"
#define ROOM_ID_SECOND  @"95daddc650294ddda5ea42d84dffe838"
#define TOKEN_SECOND  @"42e564342aa38b7be51bda37f5590f5d"

@interface TestNavigatorController ()
{
    NSString * appIdStr;
    NSString * roomIdStr;
    NSString  * userIdStr;
    NSString * tokenStr;
    
}
@end

@implementation TestNavigatorController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appIdStr = APP_ID;
    userIdStr = USER_ID_FIRST;
    roomIdStr = ROOM_ID_FIRST;
    tokenStr = TOKEN_FIRST;

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)connect:(UIButton *)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DemoViewController * demoEntry = [board instantiateViewControllerWithIdentifier:@"demoEntry"];
    [demoEntry initConnectionInfo:appIdStr roomId:roomIdStr userId:userIdStr token:tokenStr];
    demoEntry.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self.navigationController pushViewController:demoEntry animated:YES];
    [self.navigationController presentViewController:demoEntry animated:YES completion:^{
        
    }];
}
- (IBAction)roomChanged:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0)
    {
        roomIdStr = ROOM_ID_FIRST;
        userIdStr = USER_ID_FIRST;
        tokenStr = TOKEN_FIRST;
    }
    else
    {
        roomIdStr = ROOM_ID_SECOND;
        userIdStr = USER_ID_SECOND;
        tokenStr = TOKEN_SECOND;
    }
}

@end
