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

@interface GTQShowViewController ()<UITableViewDataSource, UITableViewDelegate>
/** 显示的tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 顶部的选着条件按钮的View */
@property (nonatomic, strong) GTQConditionView *conditionView;

/** 用来放当前模糊的imageView */
@property (nonatomic, strong) GTQRenderBlurView *blurImageView;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation GTQShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
}

//设置上拉刷新
- (void)setHeadRefresh {

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
