//
//  UIAlertView+APBlockHandler.h
//  LocationTracker
//
//  Created by ChenYim on 15/9/2.
//  Copyright (c) 2015年 ChenYim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^APAlertView_block_self_index)(UIAlertView *alertView, NSInteger buttonIndex);
typedef void(^APAlertView_block_self)(UIAlertView *alertView);
typedef BOOL(^APAlertView_block_shouldEnableFirstOtherButton)(UIAlertView *alertView);

@interface UIAlertView (APBlockHandler)<UIAlertViewDelegate>

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonTitles
                              Click:(APAlertView_block_self_index)clickBlk;

- (void)handlerClickedButton:(APAlertView_block_self_index)aBlock;
- (void)handlerCancel:(APAlertView_block_self)aBlock;
- (void)handlerWillPresent:(APAlertView_block_self)aBlock;
- (void)handlerDidPresent:(APAlertView_block_self)aBlock;
- (void)handlerWillDismiss:(APAlertView_block_self_index)aBlock;
- (void)handlerDidDismiss:(APAlertView_block_self_index)aBlock;
- (void)handlerShouldEnableFirstOtherButton:(APAlertView_block_shouldEnableFirstOtherButton)aBlock;

// 延时消失
- (void)showWithDuration:(NSTimeInterval)i;

@end

