//
//  UIActionSheet+APBlockHandler.m
//  TestApp
//
//  Created by ChenYim on 15/9/2.
//  Copyright (c) 2015年 9Sky. All rights reserved.
//

static const char UIActionSheet_key_clicked;
static const char UIActionSheet_key_cancel;
static const char UIActionSheet_key_willPresent;
static const char UIActionSheet_key_didPresent;
static const char UIActionSheet_key_willDismiss;
static const char UIActionSheet_key_didDismiss;

#import "UIActionSheet+APBlockHandler.h"
#import <objc/runtime.h>

@implementation UIActionSheet (APBlockHandler)

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles click:(UIActionSheet_block_self_index)clickBlk
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    
    for (NSString *otherButtonTitle in otherButtonTitles)
        [actionSheet addButtonWithTitle:otherButtonTitle];
    
    [actionSheet handlerClickedButton:clickBlk];
    
    return actionSheet;
}

- (void)handlerClickedButton:(UIActionSheet_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_clicked, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
- (void)handlerCancel:(UIActionSheet_block_self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_cancel, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerWillPresent:(UIActionSheet_block_self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_willPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerDidPresent:(UIActionSheet_block_self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_didPresent, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerWillDismiss:(UIActionSheet_block_self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_willDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)handlerDidDismiss:(UIActionSheet_block_self_index)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIActionSheet_key_didDismiss, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIActionSheet_block_self_index block = objc_getAssociatedObject(self, &UIActionSheet_key_clicked);
    
    if (block)
        block(actionSheet, buttonIndex);
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    UIActionSheet_block_self block = objc_getAssociatedObject(self, &UIActionSheet_key_cancel);
    
    if (block)
        block(actionSheet);
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    UIActionSheet_block_self block = objc_getAssociatedObject(self, &UIActionSheet_key_willPresent);
    
    if (block)
        block(actionSheet);
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    UIActionSheet_block_self block = objc_getAssociatedObject(self, &UIActionSheet_key_didPresent);
    
    if (block)
        block(actionSheet);
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIActionSheet_block_self_index block = objc_getAssociatedObject(self, &UIActionSheet_key_willDismiss);
    
    if (block)
        block(actionSheet, buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIActionSheet_block_self_index block = objc_getAssociatedObject(self, &UIActionSheet_key_didDismiss);
    
    if (block)
        block(actionSheet, buttonIndex);
}

@end
