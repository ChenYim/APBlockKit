//
//  ViewController2.m
//  KVOTest
//
//  Created by ChenYim on 16/6/23.
//  Copyright © 2016年 ChenYim. All rights reserved.
//

#import "ViewController2.h"
#import "NSObject+APObserveBlock.h"

static const BOOL APObserveBlockIsOn = YES;

#pragma mark - TestObject

@interface TestObject : NSObject

@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, strong) id idValue;
@property (nonatomic, copy) NSString *stringValue;

@end

@implementation TestObject

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
}

@end

#pragma mark - ViewController2

@interface ViewController2()

@property (nonatomic, strong) TestObject *testObj;
@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.testObj = [TestObject new];
    
    if (!APObserveBlockIsOn) {
        
        [_testObj addObserver:self forKeyPath:@"boolValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [_testObj addObserver:self forKeyPath:@"boolValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [_testObj addObserver:self forKeyPath:@"stringValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [_testObj addObserver:self forKeyPath:@"idValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];

    }
    else{
       
        __block NSInteger aIntegerValue = 100;
        
        [self observeKeyPath:@"boolValue"
                      object:_testObj
                     options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld Tag:0
                       block:^(NSString *keyPath, id object, NSDictionary<NSString *,id> *change) {
                           NSLog(@"valueChange keyPath:%@ change:%@", keyPath, change);
                           aIntegerValue += 100;
                       }];
        
        [self observeKeyPath:@"boolValue"
                      object:_testObj
                     options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld Tag:1
                       block:^(NSString *keyPath, id object, NSDictionary<NSString *,id> *change) {
                           NSLog(@"valueChange keyPath:%@ change:%@", keyPath, change);
                       }];
        
        [self observeKeyPath:@"stringValue"
                      object:_testObj
                     options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld Tag:0
                       block:^(NSString *keyPath, id object, NSDictionary<NSString *,id> *change) {
                           NSLog(@"valueChange keyPath:%@ change:%@", keyPath, change);
                       }];
        
        [self observeKeyPath:@"idValue"
                      object:_testObj
                     options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld Tag:0
                       block:^(NSString *keyPath, id object, NSDictionary<NSString *,id> *change) {
                           NSLog(@"valueChange keyPath:%@ change:%@", keyPath, change);
                       }];
    }
}

- (void)rightNavBtnClick
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BreakPoint" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavBtnClick)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)dealloc
{
    NSLog(@"ViewController2(%@) Dealloced.......",self);

    if (!APObserveBlockIsOn) {
        [_testObj removeObserver:self forKeyPath:@"boolValue" context:NULL];
        [_testObj removeObserver:self forKeyPath:@"boolValue" context:NULL];
        [_testObj removeObserver:self forKeyPath:@"stringValue" context:NULL];
        [_testObj removeObserver:self forKeyPath:@"idValue" context:NULL];
    }
    else{
        [self unObserveAllKeyPaths];
//        [self rfUnwatchObject:_testObj keyPath:@"boolValue"];
    }
}

- (IBAction)btnClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    if (tag == 100) {
        self.testObj.boolValue = YES;
    }
    if (tag == 101) {
        self.testObj.stringValue = @"123";
    }
    if (tag == 102) {
        self.testObj.idValue = [NSObject new];
    }
    if (tag == 103) {
        if (!APObserveBlockIsOn) {
            [_testObj removeObserver:self forKeyPath:@"boolValue" context:NULL];
        }
        else{
            [self unObserveKeyPath:@"boolValue" object:_testObj Tag:0];
            [self unObserveKeyPath:@"boolValue" object:_testObj Tag:1];
        }
    }
    if (tag == 104) {
        if (!APObserveBlockIsOn) {
            [_testObj removeObserver:self forKeyPath:@"stringValue" context:NULL];
        }
        else{
            [self unObserveKeyPath:@"stringValue" object:_testObj Tag:0];
        }
    }
    if (tag == 105) {
        if (!APObserveBlockIsOn) {
            [_testObj removeObserver:self forKeyPath:@"idValue" context:NULL];
        }
        else{
            [self unObserveKeyPath:@"idValue" object:_testObj Tag:0];
        }
    }
    if (tag == 106) {
        if (!APObserveBlockIsOn) {
            
        }
        else{
            [self unObserveKeyPath:@"boolValue" object:_testObj Tag:1];
        }
    }
    if (tag == 107) {
        if (!APObserveBlockIsOn) {
            
        }
        else{
            [self unObserveKeyPathOfObject:_testObj];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (!APObserveBlockIsOn) {
         NSLog(@"valueChange keyPath:%@ change:%@", keyPath, change);
    }
}

@end
