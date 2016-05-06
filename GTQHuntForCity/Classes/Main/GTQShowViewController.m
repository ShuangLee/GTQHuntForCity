//
//  GTQShowViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  ViewController的基类,封装了返回按钮,选择View,tableView

#import "GTQShowViewController.h"
#import "GTQConditionView.h"
#import "GTQRenderBlurView.h"
#import <MJRefresh.h>
#import "GTQHomeCellModel.h"
#import "GTQDetailViewController.h"
#import "GTQRmdTableViewCell.h"
#import "GTQRefreshHeader.h"
#import "UIImage+Size.h"
#import "GTQMapViewController.h"

@interface GTQShowViewController ()<UITableViewDataSource, UITableViewDelegate,GTQConditionViewDelegate, GTQRenderBlurViewDelegate>
/** 显示的tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 顶部的选着条件按钮的View */
@property (nonatomic, strong) GTQConditionView *conditionView;

/** 用来放当前模糊的imageView */
@property (nonatomic, strong) GTQRenderBlurView *blurImageView;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datas;

/** 地图的控制器 */
@property (nonatomic, strong) GTQMapViewController *mapVC;
@end

@implementation GTQShowViewController
////重新定义导航条的状态
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavigationItem];
    
    //初始化UI
    [self setUpUI];
    
    //设置上拉刷新
    [self setHeadRefresh];
}

//懒加载
- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CellDatas" ofType:@"plist"]];
        for (NSDictionary *dict in arr) {
            GTQHomeCellModel *model = [GTQHomeCellModel cellModelWithDict:dict];
            [_datas addObject:model];
        }
    }
    
    return _datas;
}

//设置导航条
- (void)setupNavigationItem {
    UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItemButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    rightItemButton.contentMode = UIViewContentModeCenter;
    rightItemButton.frame = CGRectMake(0, 0, 25, 25);
    [rightItemButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
}

//初始化UI
- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //添加顶部条件选择view
    self.conditionView = [[GTQConditionView alloc] init];
    CGFloat conditionViewW = ScreenWidth * 0.9;
    CGFloat conditionViewH = conditionViewW * 0.13;
    CGFloat conditionViewX = ScreenWidth * 0.05;
    CGFloat conditionViewY = 10;
    self.conditionView.frame = CGRectMake(conditionViewX, conditionViewY, conditionViewW, conditionViewH);
    self.conditionView.delegate = self;
    [self.view addSubview:self.conditionView];
    
    //初始化地图
    self.mapVC = [[GTQMapViewController alloc] init];
    [self addChildViewController:self.mapVC];
    [self.view insertSubview:self.mapVC.view belowSubview:self.conditionView];
    self.mapVC.view.alpha = 0;
    self.mapVC.view.hidden = YES;
}

//返回上个控制器
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置上拉刷新
- (void)setHeadRefresh {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    GTQRefreshHeader *header = [GTQRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}

//下拉加载数据
- (void)loadNewData
{
    //模拟1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTQHomeCellModel *model = self.datas[indexPath.row];
    GTQRmdTableViewCell *cell = [GTQRmdTableViewCell cellWithTableView:self.tableView model:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GTQRmdCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //推出详情页 将对应的模型取出并传到详情页的模型里
    GTQDetailViewController *detail = [[GTQDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - GTQConditionViewDelegate
- (void)conditionView:(GTQConditionView *)view didButtonClickFrom:(GTQConditionButtonType)fromType to:(GTQConditionButtonType)toType {
    //渲染当前的tableView的图片,并且模糊
    if (self.blurImageView == nil) {
        self.blurImageView = [GTQRenderBlurView renderBlurViewWithImage:[UIImage imageWithCaputureView:self.tableView]];
        self.blurImageView.delegate = self;
        
        CGFloat blurY = self.view.bounds.size.height == ScreenHeight ? 64 : 0;
        
        self.blurImageView.frame = CGRectMake(0, blurY, ScreenWidth, ScreenHeight - 64);
        [self.view insertSubview:self.blurImageView belowSubview:self.conditionView];
        [UIView animateWithDuration:0.3 animations:^{
            self.blurImageView.alpha = 1.0;
        }];
    }
}

- (void)conditionViewdidSelectedList:(GTQConditionView *)view {
    //隐藏地图视图
    [UIView animateWithDuration:0.3 animations:^{
        self.mapVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.mapVC.view.hidden = YES;
    }];

}

- (void)conditionViewdidSelectedMap:(GTQConditionView *)view {
    //隐藏模糊的view
    [self hideBlurView];
    
    //显示地图视图
    self.mapVC.view.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mapVC.view.alpha = 1.0;
    }];
}

//取消选中条件
- (void)conditionViewCancelSelectButton:(GTQConditionView *)view {
    //隐藏模糊的view
    [self hideBlurView];
}

//隐藏模糊的view
- (void)hideBlurView
{
    [self.blurImageView hideBlurView];
    self.blurImageView = nil;
}

#pragma mark - GTQRenderBlurViewDelegate
//点击了X号
- (void)renderBlurViewCancelBtnClick:(GTQRenderBlurView *)view {
    //取消所有按钮的选中状态
    [self.conditionView cancelSelectedAllButton];
    self.blurImageView = nil;
}

//选择了按钮
- (void)renderBlurView:(GTQRenderBlurView *)view didSelectedCellWithTitle:(NSString *)title {
    //TODO:get new data
    [self.tableView.mj_header beginRefreshing];
    self.blurImageView = nil;
    [self.conditionView cancelSelectedAllButton];
}

#pragma mark - 滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.conditionView.alpha = 0;//隐藏
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.conditionView.alpha = 1;
        }];
    }
}

@end
