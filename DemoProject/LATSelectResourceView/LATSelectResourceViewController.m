//
//  ResourceViewController.m
//  whiteboard_sdk
//
//  Created by mac on 2021/4/29.
//

#import <AVFoundation/AVFoundation.h>
#import "LATSelectResourceViewController.h"
#import <LATWhiteboard/LATWhiteboard.h>



@interface LATSelectResourceViewController ()

@end
#define DefaultInputRect CGRectMake(200,200,400,400)
@implementation LATSelectResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"资源管理";
}

- (IBAction)loadFromCamera:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO
                             completion:nil];
    [self requestAuthorization];
}

- (IBAction)loadFromAlbum:(UIBarButtonItem *)sender {

    [self showImagePickerView:NO];
}
- (IBAction)loadFromFile:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO
                             completion:nil];
    [self showFilePickerView];
}

- (IBAction)selectFromDeskless:(UIBarButtonItem *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showImagePickerView:(BOOL)camera_
{
    UIImagePickerController * controller = [[UIImagePickerController alloc] init];
    controller.sourceType = (camera_)?UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self dismissViewControllerAnimated:NO
                             completion:nil];

    [_uiDelegate presentViewController:controller];
}
-(void)showFilePickerView{
    UIDocumentPickerViewController * picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:[NSArray arrayWithObjects:@"public.item",@"com.microsoft.word.doc",@"com.microsoft.powerpoint.ppt",@"com.microsoft.excel.xls",@"com.adobe.pdf",nil] inMode:UIDocumentPickerModeImport];
    picker.delegate = self;
    [self.uiDelegate presentViewController:picker];
}
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{
    for(NSURL * url in urls)
    {
        LATFileInfo * fileInfo = [[LATFileInfo alloc] initWithParams:url.path withName:url.lastPathComponent withLeft:DefaultInputRect.origin.x withTop:DefaultInputRect.origin.y withWidth:DefaultInputRect.size.width withHeight:DefaultInputRect.size.height];
    
        [[LATWhiteboardControl instance] insertFile:fileInfo];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
            
    }];
}
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    LATFileInfo * fileInfo = [[LATFileInfo alloc] initWithParams:url.path withName:url.lastPathComponent withLeft:DefaultInputRect.origin.x withTop:DefaultInputRect.origin.y withWidth:DefaultInputRect.size.width withHeight:DefaultInputRect.size.height];

    [[LATWhiteboardControl instance] insertFile:fileInfo];
    
    [controller dismissViewControllerAnimated:YES completion:^{
            
    }];
}
-(void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    for(id value in info.allKeys)
    {
        NSLog(@"%@",value);
    }
    NSString* path = [LATUtils saveImagetoLocation:info[UIImagePickerControllerOriginalImage] location:ImageCachePath];

    [[LATWhiteboardControl instance] insertImage:path rect:DefaultInputRect];
 
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:picker completion:nil];
}
-(void)requestAuthorization{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch(status)
    {
        case AVAuthorizationStatusAuthorized:
            [self showImagePickerView:YES];
            break;
        case AVAuthorizationStatusDenied:
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted)
                {
                    NSLog(@"granted");
                    [self showImagePickerView:YES];
                }
                else
                {
                    NSLog(@"not granted");
                }
            }];
        }
    }
}
@end
