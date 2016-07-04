//
//  UIKit_APBlockHandlerVC.m
//  TestApp
//
//  Created by ChenYim on 15/9/2.
//  Copyright (c) 2015年 9Sky. All rights reserved.
//

#import "ViewController3.h"
#import "APBlockKit.h"

@interface ViewController3()
<
    UIActionSheetDelegate,
    UIAlertViewDelegate,
    UITextViewDelegate,
    UITextFieldDelegate
>

@property (nonatomic, assign) BOOL intoBlockMode;
@property (nonatomic, weak) IBOutlet UISwitch *blockSwitch;
@property (nonatomic, weak) IBOutlet UILabel *logoutLabel;
@property (nonatomic, strong) UITextView *demoTextView;
@property (nonatomic, strong) UITextField *demoTextfiled;


@end

@implementation ViewController3

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ViewController3" bundle:[NSBundle mainBundle]];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.blockSwitch setOn:YES];
    _intoBlockMode = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    if (_demoTextView) {
        [UIView animateWithDuration:1.0 animations:^{
            _demoTextView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_demoTextView removeFromSuperview];
        }];
        _demoTextView = nil;
    }
    
    if (_demoTextfiled) {
        [UIView animateWithDuration:1.0 animations:^{
            _demoTextfiled.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_demoTextfiled removeFromSuperview];
        }];
        _demoTextfiled = nil;
    }
}

#pragma mark - IBAction

- (IBAction)switchValueChanged:(id)sender {
    
    _intoBlockMode = self.blockSwitch.isOn;
}

- (IBAction)btnClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    if (tag == 1001) { // UIAlertView
        [self showUIAlertView];
    }
    
    if (tag == 1002) { // UIActionSheet
        [self showUIActionSheet];
    }
    
    if (tag == 1003 || tag == 1004 || tag == 1005 || tag == 1006|| tag == 1007) { // camerPicker
        
        [self showUIImagePickerController:tag];
    }
    
    if (tag == 1008) { // UITextView
        [self showUITextView];
    }
    
    if (tag == 1009) { // UITextfield
        [self showUITextfield];
    }
}

#pragma mark - Private Method

- (void)logout:(NSString *)info
{
    self.logoutLabel.text = info;
}

- (void)showUITextView
{
    _demoTextView = [[UITextView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)*0.5, 20, 200, 50)];
    _demoTextView.backgroundColor = [UIColor lightGrayColor];
    _demoTextView.alpha = 0;
    [self.view addSubview:_demoTextView];
    [UIView animateWithDuration:1.0 animations:^{
        _demoTextView.alpha = 1.0;
    }];
    
    if (!_intoBlockMode) {
        _demoTextView.delegate = self;
    }
    else{
        
        [_demoTextView ap_setPlactHolderStr:@"thie is a placeholder"];
        [_demoTextView ap_setDismissKeyBoardOnReturn];
        
        [_demoTextView handleShouldBeginEditing:^BOOL(UITextView *textView) {
            
            NSLog(@"TextView ShouldBeginEditing");
            return YES;
        }];
        
        [_demoTextView handleShouldEndEditing:^BOOL(UITextView *textView) {
            
            NSLog(@"TextView ShouldEndEditing");
            return YES;
        }];
        
        [_demoTextView handleDidBeginEditing:^(UITextView *textView) {
            
            NSLog(@"TextView DidBeginEditing");
        }];
        
        [_demoTextView handleShouldChangeTextInRange:^BOOL(UITextView *textView, NSRange range, NSString *text) {
           
            NSLog(@"TextView ShouldChangeTextInRange range:%@ text:%@",NSStringFromRange(range),text);
            return YES;
        }];
        
        [_demoTextView handleDidChange:^(UITextView *textView) {
            
            NSLog(@"TextView DidChange");
        }];
        
        [_demoTextView handleDidEndEditing:^(UITextView *textView) {
          
            NSLog(@"TextView DidEndEditing");
        }];
    }
}

- (void)showUITextfield
{
    _demoTextfiled = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)*0.5, 20, 200, 50)];
    _demoTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _demoTextfiled.backgroundColor = [UIColor lightGrayColor];
    _demoTextfiled.alpha = 0;
    [self.view addSubview:_demoTextfiled];
    [UIView animateWithDuration:1.0 animations:^{
        _demoTextfiled.alpha = 1.0;
    }];
    
    if (!_intoBlockMode) {
        _demoTextfiled.delegate = self;
    }
    else{
        [_demoTextfiled ap_setPlactHolderStr:@"thie is a placeholder"];
        [_demoTextfiled ap_setDismissKeyBoardOnReturn];
        
        [_demoTextfiled handleShouldBeginEditing:^BOOL(UITextField *textField) {
            
            NSLog(@"textField ShouldBeginEditing");
            return YES;
        }];
        
        [_demoTextfiled handleDidBeginEditing:^(UITextField *textField) {
            
            NSLog(@"textField DidBeginEditing");
        }];
        
        [_demoTextfiled handleShouldEndEditing:^BOOL(UITextField *textField) {
            
            NSLog(@"textField ShouldEndEditin");
            return YES;
        }];
        
        [_demoTextfiled handleDidEndEditing:^(UITextField *textField) {
            
            NSLog(@"textField DidEndEditing");
        }];
        
        [_demoTextfiled handleShouldChangeCharactersInRange:^BOOL(UITextField *textField, NSRange range, NSString *text) {
            
            NSLog(@"textField ShouldChangeCharactersInRange range:%@ text:%@",NSStringFromRange(range),text);
            return YES;
        }];
        
        [_demoTextfiled handleShouldClear:^BOOL(UITextField *textField) {
            
            NSLog(@"textField ShouldClear");
            return YES;
        }];
        
        [_demoTextfiled handleShouldReturn:^BOOL(UITextField *textField) {
            
            NSLog(@"textField ShouldReturn");
            return YES;
        }];
    }
}

- (void)showUIImagePickerController:(NSInteger)tag
{
    if (tag == 1003) { // albumPicker
    
        UIImagePickerController *cameraPickVC = [[UIImagePickerController alloc] init];
        [cameraPickVC openCameraPickerFrom:self AllowsEditing:YES];
        [cameraPickVC handleDidFinishPickingImageBlk:^(UIImagePickerController *imagePickerVC, NSDictionary *info, UIImage *image) {
            
        }];
    }
    
    if (tag == 1004) { // albumPicker
        
        UIImagePickerController *albumPickVC = [[UIImagePickerController alloc] init];
        [albumPickVC openPhotoAlbumPickerFrom:self AllowsEditing:YES];
        [albumPickVC handleDidFinishPickingImageBlk:^(UIImagePickerController *imagePickerVC, NSDictionary *info, UIImage *image) {
            
        }];
    }
    if (tag == 1005) { // photoPicker
        
        UIImagePickerController *photoFlowPicker = [[UIImagePickerController alloc] init];
        [photoFlowPicker openPhotoFlowPickerFrom:self AllowsEditing:YES];
        [photoFlowPicker handleDidFinishPickingImageBlk:^(UIImagePickerController *imagePickerVC, NSDictionary *info, UIImage *image) {
            
        }];
    }
    
    if (tag == 1006) { // videoPicker
        
        UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
        [videoPicker openVideoPickerFrom:self AllowsEditing:NO];
        [videoPicker handleDidFinishPickingVideoBlk:^(UIImagePickerController *imagePickerVC, NSDictionary *info, NSURL *videoURL) {
            
        }];
    }
    
    if (tag == 1007) { // videoAlbumPicker
        
        UIImagePickerController *videoAlbumPicker = [[UIImagePickerController alloc] init];
        [videoAlbumPicker openVideoAlbumPickFrom:self AllowsEditing:NO];
        [videoAlbumPicker handleDidFinishPickingVideoBlk:^(UIImagePickerController *imagePickerVC, NSDictionary *info, NSURL *videoURL) {
            
        }];
    }
}

- (void)showUIActionSheet
{
    if (!_intoBlockMode) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"systemActionSheet"
                                                                 delegate:self
                                                        cancelButtonTitle:@"cancel"
                                                   destructiveButtonTitle:@"destructiveButtonTitle"
                                                        otherButtonTitles:@"button1", @"button2", @"button3", nil];
        [actionSheet showInView:self.view];
    }
    else{
        UIActionSheet *actionSheet = [UIActionSheet actionSheetWithTitle:@"blockActionSheet"
                                                       cancelButtonTitle:@"cancel"
                                                  destructiveButtonTitle:@"destructiveButtonTitle"
                                                       otherButtonTitles:@[@"button1", @"button2", @"button3"]
                                                                   click:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                                                                       
                                                                       [self logout:[NSString stringWithFormat:@"ActionSheetClick(Block) %@",@(buttonIndex)]];
                                                                   }];
        [actionSheet showInView:self.view];
    }
    
//    [APAlertController showActionSheetWithTitle:@"actionSheet" cancelButtonTitle:@"cancelBtn" destructiveButtonTitle:@"destructBtn" otherButtonTitles:@[@"btnA",@"btnB",@"btnC"] ClickBlk:^(id actionst, NSInteger btnIndex) {
//         NSLog(@"clcik %@",actionst);
//        NSLog(@"clcik %@",[NSString stringWithInteger:btnIndex]);
//    } FromVC:self];
    
//    [APAlertController showActionSheetWithTitle:@"actionSheet" cancelButtonTitle:@"cancelBtn" destructiveButtonTitle:@"destructBtn" otherButtonTitles:@[@"btnA",@"btnB",@"btnC"] ClickBlk:^(id obj ,NSInteger btnIndex) {
//        
//    } FromVC:self];
    

    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructiveButtonTitle" otherButtonTitles:@"button1", @"button2", @"button3", nil];
//    [actionSheet showInView:self.view];
}

- (void)showUIAlertView
{
    if (!_intoBlockMode) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"systemAlert"
                                                            message:@"Message"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"click1",@"click2",@"click3", nil];
        [alertView show];
    }
    else{
        
        UIAlertView *alertView = [UIAlertView alertViewWithTitle:@"blockAlert"
                                                         message:@"Message"
                                               cancelButtonTitle:@"cancel"
                                               otherButtonTitles:@[@"click1",@"click2",@"click3"]
                                                           Click:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                               [self logout:[NSString stringWithFormat:@"AlertViewClick(Block) %@",@(buttonIndex)]];
                                                           }];
        
        [alertView handlerShouldEnableFirstOtherButton:^BOOL(UIAlertView *alertView) {
            return YES;
        }];
        [alertView handlerWillPresent:^(UIAlertView *alertView) {
            
        }];
        [alertView handlerDidPresent:^(UIAlertView *alertView) {
            
        }];
        [alertView handlerWillDismiss:^(UIAlertView *alertView, NSInteger btnIndex) {
            
        }];
        [alertView handlerDidDismiss:^(UIAlertView *alertView, NSInteger btnIndex) {
            
        }];
        [alertView show];
    }
}

#pragma mark - DelegateMethod

// UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self logout:[NSString stringWithFormat:@"AlertViewClick(Delegate) %@",@(buttonIndex)]];
}

// UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   [self logout:[NSString stringWithFormat:@"ActionSheetClick(Delegate) %@",@(buttonIndex)]];
}





@end
