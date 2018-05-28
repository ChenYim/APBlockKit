//
//  UITextView+APBlockHandler.m
//  TestApp
//
//  Created by ChenYim on 15/8/24.
//  Copyright (c) 2015年 __companyName__. All rights reserved.
//

static const char APTextView_Key_DismissKeyBoardOnReturn;
static const char APTextView_Key_PlaceHolderStr;
static const char APTextView_Key_ShouldBeginEditing;
static const char APTextView_Key_ShouldEndEditing;
static const char APTextView_Key_DidBeginEditing;
static const char APTextView_Key_DidEndEditing;
static const char APTextView_Key_ShouldChangeTextInRange;
static const char APTextView_Key_DidChange;

#import "UITextView+APBlockHandler.h"
#import <objc/runtime.h>

@interface UITextView()<UITextViewDelegate>

@end

@implementation UITextView (APBlockHandler)

- (void)ap_setPlactHolderStr:(NSString *)str
{
    self.delegate = self;
    NSString *placeHolder = objc_getAssociatedObject(self, &APTextView_Key_PlaceHolderStr);
    if (!placeHolder) {
        objc_setAssociatedObject(self, &APTextView_Key_PlaceHolderStr, str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.text = str;
}

-(void)ap_setDismissKeyBoardOnReturn
{
    self.delegate = self;
    self.returnKeyType = UIReturnKeyDone;
    NSNumber *dismissKBOnReturnNumber = objc_getAssociatedObject(self, &APTextView_Key_DismissKeyBoardOnReturn);
    if (![dismissKBOnReturnNumber boolValue]) {
        objc_setAssociatedObject(self, &APTextView_Key_DismissKeyBoardOnReturn, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)handleShouldBeginEditing:(APTextView_BOOLBlock_Self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_ShouldBeginEditing, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleShouldEndEditing:(APTextView_BOOLBlock_Self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_ShouldEndEditing, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleDidBeginEditing:(APTextView_Block_Self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_DidBeginEditing, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleDidEndEditing:(APTextView_Block_Self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_DidEndEditing, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleShouldChangeTextInRange:(APTextView_BOOLBlock_Self_Range_ReplaceText)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_ShouldChangeTextInRange, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleDidChange:(APTextView_Block_Self)aBlock
{
    self.delegate = self;
    objc_setAssociatedObject(self, &APTextView_Key_DidChange, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    APTextView_BOOLBlock_Self blk = objc_getAssociatedObject(self, &APTextView_Key_ShouldBeginEditing);
    [self configPlaceHolder_ShouldBeginEditing];
    if (blk) {
        return blk(textView);
    }
    else
        return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    APTextView_Block_Self blk = objc_getAssociatedObject(self, &APTextView_Key_DidBeginEditing);
    if (blk) {
        blk(textView);
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    APTextView_BOOLBlock_Self blk = objc_getAssociatedObject(self, &APTextView_Key_ShouldEndEditing);
    [self configPlaceHolder_ShouldEndEditing];
    if (blk) {
        return blk(textView);
    }
    else
        return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    APTextView_Block_Self blk = objc_getAssociatedObject(self, &APTextView_Key_DidEndEditing);
    
    if (blk) {
        blk(textView);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    APTextView_BOOLBlock_Self_Range_ReplaceText blk = objc_getAssociatedObject(self, &APTextView_Key_ShouldChangeTextInRange);
    [self configKeyBoardDismiss_ShouleChangeText:text];
    if (blk) {
        return blk(textView, range, text);
    }
    else
        return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    APTextView_Block_Self blk = objc_getAssociatedObject(self, &APTextView_Key_DidChange);
    if (blk) {
        blk(textView);
    }
}

#pragma mark - PRIVATE
- (void)configPlaceHolder_ShouldEndEditing
{
    NSString *placeHolder = objc_getAssociatedObject(self, &APTextView_Key_PlaceHolderStr);
    
    if ([self.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 && placeHolder!=nil) {
        self.text = placeHolder;
    }
}
- (void)configPlaceHolder_ShouldBeginEditing
{
    NSString *placeHolder = objc_getAssociatedObject(self, &APTextView_Key_PlaceHolderStr);
    
    if ([self.text isEqualToString:placeHolder]) {
        self.text = @"";
    }
}

- (void)configKeyBoardDismiss_ShouleChangeText:(NSString *)text
{
    NSNumber *dismissKBOnReturnNumber = objc_getAssociatedObject(self, &APTextView_Key_DismissKeyBoardOnReturn);
    
    if ([text isEqualToString:@"\n"] && [dismissKBOnReturnNumber boolValue]) {
        [self resignFirstResponder];
    }
}
@end
