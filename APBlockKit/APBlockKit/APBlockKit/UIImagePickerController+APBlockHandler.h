//
//  UIImagePickerController+APBlockHandler.h
//  TestApp
//
//  Created by ChenYim on 15/8/24.
//  Copyright (c) 2015年 9Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIImagePick_APBlock)(UIImagePickerController *imagePickerVC);
typedef void(^UIImagePick_APImageBlock)(UIImagePickerController *imagePickerVC, NSDictionary *info, UIImage *image);
typedef void(^UIImagePick_APVideoBlock)(UIImagePickerController *imagePickerVC, NSDictionary *info, NSURL *videoURL);

@interface UIImagePickerController (APBlockHandler)

- (void)openVideoAlbumPickFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing;
- (void)openVideoPickerFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing;
- (void)openCameraPickerFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing;
- (void)openPhotoAlbumPickerFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing;
- (void)openPhotoFlowPickerFrom:(UIViewController *)vc AllowsEditing:(BOOL)ifAllowEditing;

- (void)handleDidFinishPickingImageBlk:(UIImagePick_APImageBlock)aBlock;
- (void)handleDidFinishPickingVideoBlk:(UIImagePick_APVideoBlock)aBlock;

- (void)handleDidCancelBlk:(UIImagePick_APBlock)aBlock;


@end
