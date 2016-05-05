//
//  GTQHomeViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQHomeViewController.h"
#import "GTQRmdTableViewCell.h"
#import "GTQRmdHeaderView.h"
#import "GTQHomeModel.h"
#import "GTQHomeCellModel.h"
#import "GTQDetailViewController.h"
#import "GTQHeaderPushViewController.h"

//推荐cell的高度
#define GTQRmdCellHeight 210.0
//推荐headView的高度
#define GTQRmdHeadViewHeight 60.0

@interface GTQHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
//** 导航titileView */
@property (nonatomic, weak) UISegmentedControl *titleView;
//推荐View
@property (nonatomic, strong) UITableView *recommendTableView;
//附近提示图
@property (nonatomic, strong) UIImageView *nearImageView;
/** 首页的数据源 */
@property (nonatomic, strong) NSMutableArray *datas;
/** cell的模型 */
@property (nonatomic, strong) NSMutableArray *cellDatas;
//headModels，用来控制headView的属性
@property (nonatomic, strong) NSMutableArray *headModels;
@end

@implementation GTQHomeViewController

//重新定义导航条的状态
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavigationItem];
    
    //初始化UI
    [self setupUI];
}

/*
 *设置导航条
 */
- (void)setupNavigationItem {
    //设置导航条的titleView
    UISegmentedControl *titleV = [[UISegmentedControl alloc] initWithItems:@[@"推荐", @"附近"]];
    [titleV setTintColor:RGBCOLOR(26, 163, 146)];
    titleV.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 30);
    //文字设置
    NSMutableDictionary *attributeDic = [NSMutableDictionary dictionary];
    attributeDic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    attributeDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [titleV setTitleTextAttributes:attributeDic forState:UIControlStateNormal];
    [titleV setTitleTextAttributes:attributeDic forState:UIControlStateSelected];
    titleV.selectedSegmentIndex = 0;
    [titleV addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
    _titleView = titleV;
    self.navigationItem.titleView = _titleView;
}


/*
 *初始化视图
 */
- (void)setupUI {
    //设置背景色
    [self.view setBackgroundColor:RGBCOLOR(51, 52, 53)];
    
    //推荐tableview
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recommendTableView = tableV;
    _recommendTableView.delegate = self;
    _recommendTableView.dataSource = self;
    //默认显示
    [self.view addSubview:_recommendTableView];
    _recommendTableView.backgroundColor = self.view.backgroundColor;
    
    //附近视图
    self.nearImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.nearImageView setImage:[UIImage imageNamed:@"wnxBG"]];
}

#pragma mark - titleViewAction
/*
 *导航条title点击
 */
- (void)titleViewChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        //显示推荐视图
        [self.view addSubview:self.recommendTableView];
        [self.nearImageView removeFromSuperview];
    } else {
        //显示附近视图
        [self.view addSubview:self.nearImageView];
        [self.recommendTableView removeFromSuperview];
    }
}

#pragma mark - TableViewDelegate和TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GTQHomeModel *model = self.datas[section];
    return model.body.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTQHomeModel *homeModel = self.datas[indexPath.section];
    GTQHomeCellModel *cellModel = [GTQHomeCellModel cellModelWithDict:homeModel.body[indexPath.row]];
    
    GTQRmdTableViewCell *cell = [GTQRmdTableViewCell cellWithTableView:tableView model:cellModel];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GTQHomeModel *headModel = self.datas[section];
    GTQRmdHeaderView *headView = [GTQRmdHeaderView headViewWith:headModel];
    
    //添加手势点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTap:)];
    [headView addGestureRecognizer:tap];
    
    return headView;
}



//返回每个headView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return GTQRmdHeadViewHeight;
}

//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GTQRmdCellHeight;
}

#pragma mark - 懒加载
- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeDatas" ofType:@"plist"]];
        for (NSDictionary *dict in tmpArr) {
            GTQHomeModel *homeModel = [GTQHomeModel homeModelWithDict:dict];
            [_datas addObject:homeModel];
        }
    }
    
    return _datas;
}

#pragma mark - HeadView点击手势
- (void)headViewTap:(UITapGestureRecognizer *)tap {
    GTQRmdHeaderView *headView = (GTQRmdHeaderView *)tap.view;
    GTQHeaderPushViewController *vc = [[GTQHeaderPushViewController alloc] init];
    vc.headModel = headView.headModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 推荐tableview点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTQDetailViewController *detailVC = [[GTQDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
