//
//  GTQBaseViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//  控制器基类

#import "GTQBaseViewController.h"

@interface GTQBaseViewController ()

@end

@implementation GTQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  添加导航条上的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem cr]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
