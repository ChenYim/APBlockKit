//
//  UITextField+APBlockHandler.h
//  KeDao
//
//  Created by ChenYim on 15/9/6.
//  Copyright (c) 2015年 skyInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^APTextField_Block_Self)(UITextField *textField);
typedef BOOL(^APTextField_BoolBlock_Self)(UITextField *textField);
typedef BOOL(^APTextField_Block_Self_Range_ReplaceText)(UITextField *textField, NSRange range, NSString *text);


@interface UITextField (APBlockHandler)

-(void)ap_setPlactHolderStr:(NSString *)str;
-(void)ap_setDismissKeyBoardOnReturn;

- (void)handleDidBeginEditing:(APTextField_Block_Self)aBlock;
- (void)handleDidEndEditing:(APTextField_Block_Self)aBlock;
- (void)handleShouldBeginEditing:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldEndEditing:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldChangeCharactersInRange:(APTextField_Block_Self_Range_ReplaceText)aBlock;
- (void)handleShouldClear:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldReturn:(APTextField_BoolBlock_Self)aBlock;

@end
