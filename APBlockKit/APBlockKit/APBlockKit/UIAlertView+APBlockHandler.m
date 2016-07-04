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

#import "UIAlertView+APBlockHandler.h"
#import <objc/runtime.h>

@implementation UIAlertView (APBlockHandler)

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles Click:(APAlertView_block_self_index)clickBlk
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtonTitles)
        [alerView addButtonWithTitle:buttonTitle];
    
    [alerView handlerClickedButton:clickBlk];
    
    return alerView;
}

- (void)handlerClickedButton:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_clicked, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerCancel:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_cancel, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerWillPresent:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_willPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handlerDidPresent:(void (^)(UIAlertView *alertView))aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_didPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerWillDismiss:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_willDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerDidDismiss:(APAlertView_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_didDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerShouldEnableFirstOtherButton:(APAlertView_block_shouldEnableFirstOtherButton)aBlock
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

- (void)showWithDuration:(NSTimeInterval)i
{
    [NSTimer scheduledTimerWithTimeInterval:i
                                     target:self
                                   selector:@selector(xyDismiss)
                                   userInfo:self
                                    repeats:NO];
    [self show];
}

- (void)xyDismiss
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}


@end
