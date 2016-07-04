//
//  ViewController.m
//  KVOTest
//
//  Created by ChenYim on 16/6/22.
//  Copyright © 2016年 ChenYim. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+APObserveBlock.h"

static const BOOL APObserveBlockIsOn = YES;

NSString * const ABCNotification = @"ABCNotification";
NSString * const DEFNotification = @"DEFNotification";

@interface ViewController ()
@property (nonatomic, strong) NSObject *posterA;
@property (nonatomic, strong) NSObject *posterB;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.posterA = [NSObject new];
    self.posterB = [NSObject new];
    
    if (!APObserveBlockIsOn) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleABCNotification:) name:ABCNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleABCNotificationPostedByA:) name:ABCNotification object:self.posterA];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleABCNotificationPostedByA2:) name:ABCNotification object:self.posterA];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleABCNotificationPostedByB:) name:ABCNotification object:self.posterB];

    }
    else{

         __weak __typeof(self) weakSelf = self;
        [self observeEvent:ABCNotification object:nil block:^(NSNotification * _Nonnull aNote) {
            [weakSelf handleABCNotification:aNote];
        }];
        [self observeEvent:ABCNotification object:_posterA block:^(NSNotification * _Nonnull aNote) {
            [weakSelf handleABCNotificationPostedByA:aNote];
        }];
        [self observeEvent:ABCNotification object:_posterA block:^(NSNotification * _Nonnull aNote) {
            [weakSelf handleABCNotificationPostedByA2:aNote];
        }];
        [self observeEvent:ABCNotification object:_posterB block:^(NSNotification * _Nonnull aNote) {
            [weakSelf handleABCNotificationPostedByB:aNote];
        }];
        [self observeEvent:DEFNotification object:nil block:^(NSNotification * _Nonnull aNote) {
            NSLog(@"receiveDEFNote object:nil");
        }];
        [self observeEvent:DEFNotification object:_posterA block:^(NSNotification * _Nonnull aNote) {
            NSLog(@"receiveDEFNote object: PosterA");
        }];
        [self observeEvent:DEFNotification object:_posterB block:^(NSNotification * _Nonnull aNote) {
            NSLog(@"receiveDEFNote object: PosterB");
        }];
    }
}

- (void)rightNavBtnClick
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BreakPoint"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightNavBtnClick)];
}

- (void)dealloc
{
    NSLog(@"ViewController(%@) Dealloced.......",self);
}

- (void)handleABCNotification:(NSNotification *)note
{
    NSLog(@"NOTIFICATION RECEIVED: OBJ:nil | NOTE:%@",note);
}

- (void)handleABCNotificationPostedByA:(NSNotification *)note
{
    NSLog(@"NOTIFICATION RECEIVED: PosterA OBJ:nil | NOTE:%@",note);
}

- (void)handleABCNotificationPostedByA2:(NSNotification *)note
{
    NSLog(@"receiveNote object: PosterA2 note:%@",note);
    
}

- (void)handleABCNotificationPostedByB:(NSNotification *)note
{
    NSLog(@"receiveNote object: PosterB");

}


- (IBAction)btnClick:(id)sender {
    
    UIButton *button = sender;
    
    if (!APObserveBlockIsOn) {
        
        switch (button.tag) {
                
            case 100:{
                [[NSNotificationCenter defaultCenter] postNotificationName:ABCNotification object:nil];
            }break;
            case 101:{
                [[NSNotificationCenter defaultCenter] postNotificationName:ABCNotification object:_posterA];
                
            }break;
            case 102:{
                [[NSNotificationCenter defaultCenter] postNotificationName:ABCNotification object:_posterB];
                
            }break;
            case 103:{
                [[NSNotificationCenter defaultCenter] postNotificationName:DEFNotification object:nil];
            }break;
            case 104:{
                [[NSNotificationCenter defaultCenter] postNotificationName:DEFNotification object:_posterA];
                
            }break;
            case 105:{
                [[NSNotificationCenter defaultCenter] postNotificationName:DEFNotification object:_posterB];
                
            }break;
            case 106:{
                [[NSNotificationCenter defaultCenter] removeObserver:self];
            }break;
            case 107:{
                [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
            }break;
            case 108:{
                [[NSNotificationCenter defaultCenter] removeObserver:self name:ABCNotification object:nil];
            }break;
            case 109:{
                [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:_posterA];
            }break;
            case 110:{
                [[NSNotificationCenter defaultCenter] removeObserver:self name:ABCNotification object:_posterA];
            }break;
        }

    }
    else{
        switch (button.tag) {
                
            case 100:{
                [[NSNotificationCenter defaultCenter] postNotificationName:ABCNotification object:nil];
            }break;
            case 101:{
                [_posterA postEvent:ABCNotification userInfo:nil];
                
            }break;
            case 102:{
                [_posterB postEvent:ABCNotification userInfo:nil];
                
            }break;
            case 103:{
                [[NSNotificationCenter defaultCenter] postNotificationName:DEFNotification object:nil];
            }break;
            case 104:{
                [_posterA postEvent:DEFNotification userInfo:nil];
            }break;
            case 105:{
                [_posterB postEvent:DEFNotification userInfo:nil];
            }break;
            case 106:{
                [self unObserveEvent:nil object:nil];
            }break;
            case 107:{
                [self unObserveEvent:nil object:nil];
            }break;
            case 108:{
                [self unObserveEvent:ABCNotification object:nil];
            }break;
            case 109:{
                [self unObserveEvent:nil object:_posterA];
            }break;
            case 110:{
                [self unObserveEvent:ABCNotification object:_posterA];
            }break;
            default:
                break;
        }

        
    }
}
@end
