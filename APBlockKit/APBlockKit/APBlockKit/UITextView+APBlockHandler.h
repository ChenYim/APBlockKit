//
//  UITextView+APBlockHandler.h
//  TestApp
//
//  Created by ChenYim on 15/8/24.
//  Copyright (c) 2015年 __companyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^APTextView_Block_Self)(UITextView *textView);
typedef BOOL(^APTextView_BOOLBlock_Self)(UITextView *textView);
typedef BOOL(^APTextView_BOOLBlock_Self_Range_ReplaceText)(UITextView *textView, NSRange range, NSString *text);

@interface UITextView (APBlockHandler)

- (void)ap_setPlactHolderStr:(NSString *)str;
- (void)ap_setDismissKeyBoardOnReturn;

- (void)handleShouldBeginEditing:(APTextView_BOOLBlock_Self)aBlock;
- (void)handleShouldEndEditing:(APTextView_BOOLBlock_Self)aBlock;
- (void)handleDidBeginEditing:(APTextView_Block_Self)aBlock;
- (void)handleDidEndEditing:(APTextView_Block_Self)aBlock;
- (void)handleShouldChangeTextInRange:(APTextView_BOOLBlock_Self_Range_ReplaceText)aBlock;
- (void)handleDidChange:(APTextView_Block_Self)aBlock;

@end
