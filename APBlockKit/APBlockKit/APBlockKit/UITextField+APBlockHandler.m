//
//  UITextField+APBlockHandler.m
//  KeDao
//
//  Created by ChenYim on 15/9/6.
//  Copyright (c) 2015年 skyInfo. All rights reserved.
//


#import "UITextField+APBlockHandler.h"
#import <objc/objc.h>
#import <objc/runtime.h>

static const char APTextFieldKey_APBlockHandler;

#pragma mark - APTextFieldBlockHandler
@interface APTextFieldBlockHandler : NSObject <UITextFieldDelegate>

@property (nonatomic, copy) APTextField_Block_Self                   didBeginEditingBlock;
@property (nonatomic, copy) APTextField_Block_Self                   didEndEditing;
@property (nonatomic, copy) APTextField_BoolBlock_Self               shouldBeginEditingBlk;
@property (nonatomic, copy) APTextField_BoolBlock_Self               shouldEndEditingBlk;
@property (nonatomic, copy) APTextField_Block_Self_Range_ReplaceText shouldChangeCharactersInRangeBlk;
@property (nonatomic, copy) APTextField_BoolBlock_Self               shouldClearBlk;
@property (nonatomic, copy) APTextField_BoolBlock_Self               shouldReturnBlk;
@property (nonatomic, strong) NSString *plactHolderStr;
@property (nonatomic, strong) NSNumber *dismissKBOnReturnNumber;
@end

@implementation APTextFieldBlockHandler

// UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    APTextField_Block_Self blk = self.didBeginEditingBlock;
    if (blk) {
        blk(textField);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    APTextField_Block_Self blk = self.didEndEditing;
    if (blk) {
        blk(textField);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    APTextField_BoolBlock_Self blk = self.shouldBeginEditingBlk;
    
    [self configPlaceHolder_ShouldBeginEditing:textField];
    
    if (blk) {
        return blk(textField);
    }
    else{
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    APTextField_BoolBlock_Self blk = self.shouldEndEditingBlk;
    [self configPlaceHolder_ShouldEndEditing:textField];
    if (blk) {
       return  blk(textField);
    }
    else
        return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    APTextField_Block_Self_Range_ReplaceText blk = self.shouldChangeCharactersInRangeBlk;
    if (blk) {
        return blk(textField,range,string);
    }
    else
        return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    APTextField_BoolBlock_Self blk = self.shouldClearBlk;
    if (blk) {
        return blk(textField);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    APTextField_BoolBlock_Self blk = self.shouldReturnBlk;
    [self configKeyBoardDismiss:textField];
    if (blk) {
        return blk(textField);
    }
    else
        return YES;
}

#pragma mark - PRIVATE

- (void)configPlaceHolder_ShouldBeginEditing:(UITextField *)tfRef
{
    if ([tfRef.text isEqualToString:_plactHolderStr ]) {
       
        tfRef.text = @"";
    }
}

- (void)configPlaceHolder_ShouldEndEditing:(UITextField *)tfRef
{
    if ([tfRef.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 && _plactHolderStr.length != 0) {
        
        tfRef.text = _plactHolderStr;
    }
}

- (void)configKeyBoardDismiss:(UITextField *)tfRef
{
    if ([_dismissKBOnReturnNumber boolValue]) {
       
        [tfRef resignFirstResponder];
    }
}

@end

#pragma mark - UITextField (APBlockHandler)

@implementation UITextField (APBlockHandler)

// private
- (APTextFieldBlockHandler *)ap_getAPBlockHandler
{
    APTextFieldBlockHandler *blkHandler_MayNil = objc_getAssociatedObject(self, &APTextFieldKey_APBlockHandler);
    if (!blkHandler_MayNil) {
        objc_setAssociatedObject(self, &APTextFieldKey_APBlockHandler, [APTextFieldBlockHandler new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    APTextFieldBlockHandler *blockHandler = objc_getAssociatedObject(self, &APTextFieldKey_APBlockHandler);
    
    return blockHandler;
}

// public
- (void)handleDidBeginEditing:(APTextField_Block_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.didBeginEditingBlock = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleDidEndEditing:(APTextField_Block_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.didEndEditing = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleShouldBeginEditing:(APTextField_BoolBlock_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.shouldBeginEditingBlk = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleShouldEndEditing:(APTextField_BoolBlock_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.shouldEndEditingBlk = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleShouldChangeCharactersInRange:(APTextField_Block_Self_Range_ReplaceText)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.shouldChangeCharactersInRangeBlk = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleShouldClear:(APTextField_BoolBlock_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.shouldClearBlk = aBlock;
    
    self.delegate = blkHandler;
}

- (void)handleShouldReturn:(APTextField_BoolBlock_Self)aBlock
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.shouldReturnBlk = aBlock;
    
    self.delegate = blkHandler;
}

- (void)ap_setPlactHolderStr:(NSString *)str
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.plactHolderStr = str;
    
    self.text = str;
    
    self.delegate = blkHandler;
}

- (void)ap_setDismissKeyBoardOnReturn
{
    APTextFieldBlockHandler *blkHandler = [self ap_getAPBlockHandler];
    blkHandler.dismissKBOnReturnNumber = [NSNumber numberWithBool:YES];
 
    self.returnKeyType = UIReturnKeyDone;
    
    self.delegate = blkHandler;
}

@end
