//
//  ViewController.h
//  sdk_demo
//
//  Created by mac on 2021/4/22.
//

#import <UIKit/UIKit.h>
#import <LATWhiteboard/LATWhiteboard.h>


@interface DemoViewController : LATWhiteboardViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>


-(void)initConnectionInfo:(NSString *)appId_ roomId:(NSString *)roomId_ userId:(NSString *)userId_ token:(NSString *)token_;

@end

