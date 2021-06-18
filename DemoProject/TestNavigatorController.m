//
//  TestNavigatorController.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/28.
//

#import "TestNavigatorController.h"
#import "DemoViewController.h"

#if 1
#define TOKEN_FIRST @"127182d9a297292558aa3d935746827c";
#define APP_ID @"a4b26ecae3744e3fb60ff679e186cd98";
#define ROOM_ID_FIRST @"0f9ce36096bb4330bdee6ca9acd6b89f";
#define USER_ID_FIRST @"07345de7-5a80-48d4-86fd-d75635525d7d";
#else
#define APP_ID @"fd3c029d48a64afeb5b46c24aedc2995"
#define USER_ID_FIRST @"test1"
#define ROOM_ID_FIRST @"aede5dfa1c194803b40799783b5d92c2"
#define TOKEN_FIRST @"63e511d858589eab6d9e8a4d8029a1c0"
#endif

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
