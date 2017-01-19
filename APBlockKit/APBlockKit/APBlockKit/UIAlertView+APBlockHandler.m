//
//  UIAlertView+APBlockHandler.m
//  LocationTracker
//
//  Created by ChenYim on 15/9/2.
//  Copyright (c) 2015年 ChenYim. All rights reserved.
//

static const char UIAlertView_key_clicked;
static const char UIAlertView_key_cancel;
static const char UIAlertView_key_willPresent;
static const char UIAlertView_key_didPresent;
static const char UIAlertView_key_willDismiss;
static const char UIAlertView_key_didDismiss;
static const char UIAlertView_key_shouldEnableFirstOtherButton;
static const char UIAlertView_key_shouldDismissWithClickButtonIndex;

#import "UIAlertView+APBlockHandler.h"
#import <objc/runtime.h>

@implementation UIAlertView (APBlockHandler)

+ (UIAlertView *)ap_alertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles Click:(APAlertView_block_self_index)clickBlk
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtonTitles)
        [alerView addButtonWithTitle:buttonTitle];
    
    [alerView ap_handlerClickedButton:clickBlk];
    
    return alerView;
}

- (void)ap_handlerClickedButton:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_clicked, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)ap_handlerCancel:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_cancel, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)ap_handlerWillPresent:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_willPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ap_handlerDidPresent:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_didPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)ap_handlerWillDismiss:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_willDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)ap_handlerDidDismiss:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_didDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)ap_handlerShouldEnableFirstOtherButton:(APAlertView_block_shouldEnableFirstOtherButton)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_shouldEnableFirstOtherButton, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    APAlertView_block_self_index block = objc_getAssociatedObject(self, &UIAlertView_key_clicked);
    
    if (block)
        block(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    APAlertView_block_self block = objc_getAssociatedObject(self, &UIAlertView_key_cancel);
    
    if (block)
        block(alertView);
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    APAlertView_block_self block = objc_getAssociatedObject(self, &UIAlertView_key_willPresent);
    
    if (block)
        block(alertView);
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    APAlertView_block_self block = objc_getAssociatedObject(self, &UIAlertView_key_didPresent);
    
    if (block)
        block(alertView);
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    APAlertView_block_self_index block = objc_getAssociatedObject(self, &UIAlertView_key_willDismiss);
    
    if (block)
        block(alertView,buttonIndex);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    APAlertView_block_self_index block = objc_getAssociatedObject(self, &UIAlertView_key_didDismiss);
    
    if (block)
        block(alertView, buttonIndex);
}


- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    APAlertView_block_shouldEnableFirstOtherButton block = objc_getAssociatedObject(self, &UIAlertView_key_shouldEnableFirstOtherButton);
    
    if (block)
        return block(alertView);
    else
        return YES;
}

#pragma mark - UIAlertView

- (void)ap_showWithDuration:(NSTimeInterval)interval
{
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(ap_selfDismiss)
                                   userInfo:self
                                    repeats:NO];
    [self show];
}

- (void)ap_selfDismiss
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}


@end

#pragma mark - APAlertView

@implementation APAlertView

//-(void)dealloc
//{
//    NSLog(@"APAlertView dealloc%@",self);
//}

- (void)ap_handlerShouldDismissWithClickButtonIndex:(APAlertView_block_self_shouldDismissWithClickButtonIndex)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_shouldDismissWithClickButtonIndex, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Over Write
-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    APAlertView_block_self_shouldDismissWithClickButtonIndex block = objc_getAssociatedObject(self, &UIAlertView_key_shouldDismissWithClickButtonIndex);
    BOOL shouldDismiss = YES;
    if (block) {
        shouldDismiss = block(self, buttonIndex);
    }
    
    if (shouldDismiss) {
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
}


@end
