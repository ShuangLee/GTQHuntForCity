//
//  GTQHeaderPushViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  点击推荐页的headView推出的控制器

#import "GTQHeaderPushViewController.h"
#import "GTQCustomNavBar.h"
#import "GTQUnLoginView.h"

@interface GTQHeaderPushViewController ()<GTQCustomNavBarDelegate>
/** 自定义view代替系统导航条 */
@property (nonatomic, strong) GTQCustomNavBar *navBar;
@end

@implementation GTQHeaderPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(51, 52, 53, 1);
    
    //初始化UI
    [self setUI];
    
    //初始化山寨导航条
    [self setNavigitionItem];
}

/*
 *初始化导航条
 */
- (void)setNavigitionItem
{
    self.navBar = [[GTQCustomNavBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.navBar.headModel = self.headModel;
    self.navBar.delegate = self;
    [self.view addSubview:self.navBar];
}

- (void)setUI
{
    //不需要系统自动处理顶部内容伸缩
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//隐藏系统导航条
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //隐藏系统的导航条，由于需要自定义的动画，自定义一个view来代替导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    /**
     这里我尝试了设置navigationBar的背景色，设置navigationBar的setTintColor:
     设置navigationBar.layer的背景色 以及根据颜色画出navigationBar的背景图片4种办法都无法达到原生的效果
     最后采用将navigationBar隐藏，自己放一个View了冒充导航条
     */
    
}

#pragma mark - 自定义导航条的代理
//返回
- (void)customNavBarBackButtonClick:(UIButton *)sender {
    //返回上个页面
    [self.navigationController popViewControllerAnimated:YES];
}

//点击了分享按钮
- (void)customNavBarSharedButtonClick:(UIButton *)sender {
    GTQUnLoginView *view = [GTQUnLoginView unLoginView];
    [view showUnLoginViewToView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
