//
//  UIImagePickerController+APBlockHandler.m
//  TestApp
//
//  Created by ChenYim on 15/8/24.
//  Copyright (c) 2015年 __companyName__. All rights reserved.
//

static const char UIImagePick_Key_APBlock;
static const char UIImagePick_Key_APImageBlock;
static const char UIImagePick_Key_APVideoBlock;

#import "UIImagePickerController+APBlockHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImagePickerController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@interface UIImagePickerController (APPrivateMethod)
// Private
- (void)showSimpleAlertView:(NSString *)title;
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo;
@end

@implementation UIImagePickerController (APPrivateMethod)

#pragma mark - PRIVATE
- (void)showSimpleAlertView:(NSString *)title
{
    if (title.length == 0 || title == nil) {
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:title
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    
    if (!error){
        NSLog(@"picture saved with no error.");   
    }
    else{
        NSLog(@"error occured while saving the picture%@", error);
    }
}

@end

@implementation UIImagePickerController (APBlockHandler)

#pragma mark -

- (void)openVideoAlbumPickFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing
{
    ALAuthorizationStatus authorStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authorStatus == ALAuthorizationStatusDenied || authorStatus == ALAuthorizationStatusRestricted)
    {
        [self showSimpleAlertView:@"请在 \"设置-隐私-照片\" 中打开访问授权"];
        return;
    }
    
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (!isPhotoLibraryAvailable){
        [self showSimpleAlertView:@"本设备尚不支持相册"];
        return;
    }
    
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.mediaTypes = @[(NSString*)kUTTypeMovie];
    self.allowsEditing = ifAllowEditing;
    self.delegate = self;
    
    [vc presentViewController:self animated:YES completion:^{
        
    }];
}

- (void)openVideoPickerFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self showSimpleAlertView:@"本设备不支持相机"];
        return;
    }
    
    if ([[UIDevice currentDevice] systemVersion].floatValue < 6){
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus ==AVAuthorizationStatusRestricted){
        
    }else if(authStatus == AVAuthorizationStatusDenied){
        
        [self showSimpleAlertView:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"];
        return;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        
        
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                
            }
            else {
                
            }
            
        }];
    }
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = @[(NSString*)kUTTypeMovie];
    self.videoQuality = UIImagePickerControllerQualityTypeHigh;
    self.allowsEditing = ifAllowEditing;
    self.delegate = self;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    [vc presentViewController:self animated:YES completion:^{
        
    }];

}

- (void)openCameraPickerFrom:(UIViewController  *)vc AllowsEditing:(BOOL)ifAllowEditing
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self showSimpleAlertView:@"本设备不支持相机"];
        return;
    }
    
    if ([[UIDevice currentDevice] systemVersion].floatValue < 6){
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus ==AVAuthorizationStatusRestricted){
        
    }else if(authStatus == AVAuthorizationStatusDenied){
        
        [self showSimpleAlertView:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"];
        return;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        
        
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                
            }
            else {
                
            }
            
        }];
    }
    
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = @[(NSString*)kUTTypeImage];
    self.allowsEditing = ifAllowEditing;
    self.delegate = self;
    [vc presentViewController:self animated:YES completion:^{
        
    }];
}

- (void)openPhotoAlbumPickerFrom:(UIViewController  *)vc AllowsEditing:(BOOL)ifAllowEditing
{
    ALAuthorizationStatus authorStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authorStatus == ALAuthorizationStatusDenied ||
        authorStatus == ALAuthorizationStatusRestricted)
    {
        [self showSimpleAlertView:@"请在 \"设置-隐私-照片\" 中打开访问授权"];
        return;
    }
    
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (!isPhotoLibraryAvailable){
        [self showSimpleAlertView:@"本设备尚不支持相册"];
         return;
    }
    
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.mediaTypes = @[(NSString*)kUTTypeImage];
    self.allowsEditing = ifAllowEditing;
    self.delegate = self;
    [vc presentViewController:self animated:YES completion:^{
        
    }];
}

- (void)openPhotoFlowPickerFrom:(UIViewController  *)vc AllowsEditing:(BOOL)ifAllowEditing
{
    ALAuthorizationStatus authorStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authorStatus == ALAuthorizationStatusDenied ||
        authorStatus == ALAuthorizationStatusRestricted)
    {
        [self showSimpleAlertView:@"请在手机中的 \"设置-隐私-照片\" 中打开访问授权"];
        return;
    }
    
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    if (!isPhotoLibraryAvailable){
        [self showSimpleAlertView:@"本设备尚不支持相册"];
        return;
    }
    
    self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.mediaTypes = @[(NSString*)kUTTypeImage];
    self.allowsEditing = ifAllowEditing;
    self.delegate = self;
    [vc presentViewController:self animated:YES completion:^{
        
    }];
}

#pragma mark - handleMethod

-(void)handleDidCancelBlk:(UIImagePick_APBlock)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIImagePick_Key_APBlock, aBlock, OBJC_ASSOCIATION_COPY);
}

-(void)handleDidFinishPickingImageBlk:(UIImagePick_APImageBlock)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIImagePick_Key_APImageBlock, aBlock, OBJC_ASSOCIATION_COPY);
}

-(void)handleDidFinishPickingVideoBlk:(UIImagePick_APVideoBlock)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIImagePick_Key_APVideoBlock, aBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    NSLog(@"Picking Media WithInfo: %@", info);
    
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = nil;
        
        if (picker.allowsEditing)
            image = info[UIImagePickerControllerEditedImage];
        else
            image = info[UIImagePickerControllerOriginalImage];
        
        UIImage *img = image;
        if(img){
            img = [UIImage imageWithCGImage:img.CGImage scale:0.1 orientation:image.imageOrientation];
        }
    
        // 保存 拍摄的 照片
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        
        UIImagePick_APImageBlock blk = objc_getAssociatedObject(self, &UIImagePick_Key_APImageBlock);
        if (blk) {
            blk(picker, info, img);
        }

    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        
        ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // 保存视频
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
            
            if (!error){
                NSLog(@"Video Save Success");
            }
            else{
                NSLog(@"Video Save Fail!! Error:%@", error);
            }
            
        }];
        
        UIImagePick_APVideoBlock blk = objc_getAssociatedObject(self, &UIImagePick_Key_APVideoBlock);
        if (blk) {
            blk(picker, info, mediaURL);
        }
    }
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIImagePick_APBlock blk = objc_getAssociatedObject(self, &UIImagePick_Key_APBlock);
    if (blk) {
        blk(picker);
    }
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end












