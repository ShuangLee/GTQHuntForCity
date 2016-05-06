//
//  GTQFoundViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQFoundViewController.h"
#import "GTQFoundCellModel.h"
#import "GTQFoundViewLayout.h"
#import "GTQHeaderCollectionReusableView.h"
#import "GTQFoundCollectionViewCell.h"
#import "GTQShowViewController.h"

static NSString *gtqFoundCollectionViewCellIdentifier = @"GTQFoundCollectionViewCellIdentifier";
static NSString *gtqHeaderCollectionReusableViewIdetifier = @"GTQHeaderCollectionReusableViewIdetifier";

@interface GTQFoundViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, GTQFoundCollectionViewCellDelegate>
/** 展示button的colletView */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 数据,懒加载,正常情况是先发送网络请求，将服务器返回的数据解析赋值给模型在装入数组中 这里我直接写入的plist假数据 */
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *headerDatas;
@end

@implementation GTQFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化UI
    [self setupUI];
}

#pragma mark - 懒加载
//datas懒加载
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foundData" ofType:@"plist"];
        NSArray *tmpArr = [NSMutableArray arrayWithContentsOfFile:path];
        
        for (NSArray *array in tmpArr) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                GTQFoundCellModel *foundModel = [GTQFoundCellModel foundCellModelWihtDict:dic];
                [arr addObject:foundModel];
            }
            [_datas addObject:arr];
        }
    }
    
    return _datas;
}

- (NSMutableArray *)headerDatas {
    if (_headerDatas == nil) {
        _headerDatas = [NSMutableArray array];
        NSArray *arr = @[@{@"cagetory":@"分类",@"isHide":@"YES"},@{@"cagetory":@"地区",@"isHide":@"NO"}];
        for (NSDictionary *dict in arr) {
            GTQFoundHeaderModel *model = [GTQFoundHeaderModel foundHeaderModelWihtDict:dict];
            [_headerDatas addObject:model];
        }
    }
    
    return _headerDatas;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[GTQFoundViewLayout alloc] init]];
        //设置代理
        collect.delegate = self;
        collect.dataSource = self;
        collect.backgroundColor = [UIColor whiteColor];
        
        //注册headView
        [collect registerClass:[GTQHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:gtqHeaderCollectionReusableViewIdetifier];
        //注册cell
        [collect registerNib:[UINib nibWithNibName:@"GTQFoundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:gtqFoundCollectionViewCellIdentifier];
        _collectionView = collect;
    }
    
    return _collectionView;
}

- (void)setupUI {
    //设置导航title
    self.navigationItem.title = @"发现";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //添加视图
    [self.view addSubview:self.collectionView];
    //布局控件
    CGRect rect = self.view.bounds;
    rect.size.height -= 64;
    self.collectionView.frame = rect;
}

#pragma mark - UICollectionViewDataSource&UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.datas[section] count];
}

//返回collectionView的headView和footView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //取出model
    GTQFoundHeaderModel *model = self.headerDatas[indexPath.section];
    GTQHeaderCollectionReusableView *headView = [GTQHeaderCollectionReusableView headerWithCollectionView:collectionView forIndexpath:indexPath identifier:gtqHeaderCollectionReusableViewIdetifier model:model];
    return headView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //取出cell对应的模型
    GTQFoundCellModel *model = self.datas[indexPath.section][indexPath.row];
    
    //取出cell
    GTQFoundCollectionViewCell *cell = [GTQFoundCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath idetifier:gtqFoundCollectionViewCellIdentifier];
    cell.delegate = self;
    cell.foundModel = model;
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return  CGSizeMake(375, 10);
//    } else {
//        return CGSizeMake(375, 10);
//    }
//}

#pragma mark - GTQFoundCollectionViewCellDelegate
//cell的点击事件
- (void)foundCollectionViewCellDidSelected:(GTQFoundCollectionViewCell *)cell {
    GTQShowViewController *foundPushVC = [[GTQShowViewController alloc] init];
    foundPushVC.title = cell.foundModel.title;
    [self.navigationController pushViewController:foundPushVC animated:YES];
}
@end

