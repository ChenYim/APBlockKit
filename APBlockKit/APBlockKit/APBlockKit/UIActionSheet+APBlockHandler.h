//
//  UIActionSheet+APBlockHandler.h
//  TestApp
//
//  Created by ChenYim on 15/9/2.
//  Copyright (c) 2015年 __companyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIActionSheet_block_self_index)(UIActionSheet *actionSheet, NSInteger buttonIndex);
typedef void(^UIActionSheet_block_self)(UIActionSheet *actionSheet);

@interface UIActionSheet (APBlockHandler)<UIActionSheetDelegate>

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles click:(UIActionSheet_block_self_index)clickBlk;

- (void)handlerClickedButton:(UIActionSheet_block_self_index)aBlock;
- (void)handlerCancel:(UIActionSheet_block_self)aBlock;
- (void)handlerWillPresent:(UIActionSheet_block_self)aBlock;
- (void)handlerDidPresent:(UIActionSheet_block_self)aBlock;
- (void)handlerWillDismiss:(UIActionSheet_block_self)aBlock;
- (void)handlerDidDismiss:(UIActionSheet_block_self_index)aBlock;

@end
