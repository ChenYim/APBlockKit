//
//  RootViewController.m
//  KVOTest
//
//  Created by ChenYim on 16/6/23.
//  Copyright © 2016年 ChenYim. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController3.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - IBAction

- (void)rightNavBtnClick
{
    
}

- (IBAction)btnClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    if (tag == 1) {
        [self performSegueWithIdentifier:@"Segue1" sender:nil];
    }
    
    if (tag == 2) {
        [self performSegueWithIdentifier:@"Segue2" sender:nil];

    }
    
    if (tag == 3) {
        [self performSegueWithIdentifier:@"Segue3" sender:nil];
    
    }
}

@end
