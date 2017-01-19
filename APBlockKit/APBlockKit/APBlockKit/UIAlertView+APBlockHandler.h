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
typedef BOOL(^APAlertView_block_self_shouldDismissWithClickButtonIndex)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (APBlockHandler)<UIAlertViewDelegate>

+ (UIAlertView *)ap_alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonTitles
                              Click:(APAlertView_block_self_index)clickBlk;

- (void)ap_handlerClickedButton:(APAlertView_block_self_index)aBlock;
- (void)ap_handlerCancel:(APAlertView_block_self)aBlock;
- (void)ap_handlerWillPresent:(APAlertView_block_self)aBlock;
- (void)ap_handlerDidPresent:(APAlertView_block_self)aBlock;
- (void)ap_handlerWillDismiss:(APAlertView_block_self_index)aBlock;
- (void)ap_handlerDidDismiss:(APAlertView_block_self_index)aBlock;
- (void)ap_handlerShouldEnableFirstOtherButton:(APAlertView_block_shouldEnableFirstOtherButton)aBlock;


// 延时消失
- (void)ap_showWithDuration:(NSTimeInterval)i;

@end

@interface APAlertView : UIAlertView

- (void)ap_handlerShouldDismissWithClickButtonIndex:(APAlertView_block_self_shouldDismissWithClickButtonIndex)aBlock;

@end

