//
//  GTQUserInfosViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQUserInfosViewController.h"
#import "GTQUserInfoView.h"

@interface GTQUserInfosViewController ()<UIScrollViewDelegate>
/** 底部的scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) GTQUserInfoView *userInfoView;
@end

@implementation GTQUserInfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化scrollView
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    //添加用户详情view到scrollView上
    self.userInfoView = [GTQUserInfoView userInfoView];
    [self.scrollView addSubview:self.userInfoView];
    
    //设置scrollView的内容大小
    self.scrollView.contentSize = CGSizeMake(0, self.userInfoView.bounds.size.height);
    
    //添加title和back按钮
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 34)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"城觅";
    label.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:label];
    
    //添加返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 30, 30);
    CGPoint point = backBtn.center;
    point.y = label.center.y;
    backBtn.center = point;
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //将scrollView滚动的距离传给userInfoView让顶部的View自动计算反向力的距离
    [self.userInfoView userInfViewScrollOffsetY:scrollView.contentOffset.y];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
