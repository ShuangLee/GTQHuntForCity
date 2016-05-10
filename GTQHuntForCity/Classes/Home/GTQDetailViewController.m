//
//  GTQDetailViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQDetailViewController.h"
#import "GTQDetailNavBar.h"
#import "GTQScrollHeadView.h"
#import "GTQUnLoginView.h"
#import "GTQSelectView.h"
#import "GTQDetailRmdTableHeadView.h"
#import "GTQDetailTableFootView.h"
#import <MAMapKit/MAMapKit.h>
#import "GTQDetailModel.h"
#import "GTQInfoModel.h"
#import "GTQRmdCellModel.h"
#import "GTQArticleModel.h"
#import "GTQMapViewController.h"
#import "GTQRmdTextCell.h"
#import "GTQRmdPictureCell.h"
#import "GTQInfoCell.h"
#import "GTQBeenAndCollectView.h"
#import "GTQUserInfosViewController.h"

//顶部scrollHeadView 的高度
static const CGFloat ScrollHeadViewHeight = 200;
//选择View的高度
static const CGFloat SelectViewHeight = 45;

@interface GTQDetailViewController () <GTQDetailNavBarDelegate, GTQSelectViewDelegate, GTQDetailTableFootViewDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,MAMapViewDelegate>

/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat                    scrollY;
/** 记录scrollView上次偏移X的距离 */
@property (nonatomic, assign) CGFloat                    scrollX;

/** 地图view */
@property (nonatomic, strong)  MAMapView *mapView;
/** 最底部的scrollView，用来掌控所有控件的滚动 */
@property (nonatomic, strong) UIScrollView               *backgroundScrollView;
/** 用来装顶部的scrollView用的View */
@property (nonatomic, strong) UIView                     *topView;
/** 顶部的图片scrollView */
@property (nonatomic, strong) GTQScrollHeadView          *topScrollView;
/** 导航条的背景view */
@property (nonatomic, strong) UIView                     *naviView;
/** 导航条的view */
@property (nonatomic, strong) GTQDetailNavBar             *navBar;
/** 选择tableView的view */
@property (nonatomic, strong) GTQSelectView              *selectView;

/** 去过和收藏view */
@property (nonatomic, strong) GTQBeenAndCollectView      *beenAndCollectView;
/** 推荐tableView */
@property (nonatomic, strong) UITableView                *rmdTableView;
/** 信息tableView */
@property (nonatomic, strong) UITableView                *infoTableView;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, weak  ) UITableView                *showingTableView;
/** 推荐tableViewtableHeadView */
@property (nonatomic, strong) GTQDetailRmdTableHeadView *tableHeadView;
/** 所有rmdTableView的foodView */
@property (nonatomic, strong) GTQDetailTableFootView          *footView;
/** infoTableView的footView */
@property (nonatomic, strong) GTQDetailTableFootView          *footView1;
/** 推荐tableView的数据源 */
@property (nonatomic, strong) NSMutableArray             *rmdDatas;
/** 详情页的总数据 */
@property (nonatomic, strong) GTQDetailModel             *details;
/** 信息tableview的数据 */
@property (nonatomic, strong) NSMutableArray *infoDatas;

/** 电话提示 */
@property (nonatomic, strong) UIActionSheet *actionSheet;
@end

@implementation GTQDetailViewController

#pragma mark - 隐藏系统的导航条
- (void)viewDidAppear:(BOOL)animated
{
    //防止拖动一下就出现导航条的情况
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    //防止拖动一下就出现导航条的情况
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 懒加载
- (NSMutableArray *)infoDatas {
    if (_infoDatas == nil) {
        _infoDatas = [NSMutableArray array];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"infoDatas" ofType:@"plist"]];
        
        for (NSDictionary *dict in arr) {
            
            GTQInfoModel *model = [GTQInfoModel infoModelWithDict:dict];
            [_infoDatas addObject:model];
            
        }
    }
    
    return _infoDatas;
}

- (GTQDetailModel *)details
{
    if (_details == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"detailJson" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _details = [GTQDetailModel detailModelWith:dict[@"body"]];
    }
    return _details;
}

- (NSArray *)rmdDatas
{
    //自己写的json数据
    if (_rmdDatas == nil) {
        _rmdDatas = [NSMutableArray array];
        NSMutableArray *tmp = [NSMutableArray array];
        tmp = self.details.article_list[0][@"newcontent"];
        for (NSDictionary *dict in tmp) {
            GTQRmdCellModel *cellModel = [GTQRmdCellModel rmdCellModelWithDict:dict];
            [_rmdDatas addObject:cellModel];
        }
    }
    
    return _rmdDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupNavigationItem];
}

//初始化view
- (void)setupUI {
    //隐藏系统的导航条，由于需要自定义的动画，自定义一个view来代替导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //将view的自动添加scroll的内容偏移关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化最底部的scrollView,装tableView用
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backgroundScrollView];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    
    //如果tableview很多,推荐用一个tableview用一个控制器来管理，注意控制器之间的父子关系,这里先在本控制器里写
    //初始化推荐tabelView,最多有3个tableView，暂时只做俩个tableView，所以两个tableview就都在一个控制器里写了
    //如果tableview很多推荐用一个tableview用一个空气器来管理，注意控制器之间的父子关系
    self.rmdTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.rmdTableView.delegate = self;
    self.rmdTableView.dataSource = self;
    self.rmdTableView.backgroundColor = [UIColor whiteColor];
    //给顶部的图片view和选择view留出距离
    [self.backgroundScrollView addSubview:self.rmdTableView];
    self.rmdTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    //取消tableview的分割线
    self.rmdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加底部footView
    self.footView = [GTQDetailTableFootView detailFootView];
    self.footView.delegate = self;
    self.rmdTableView.tableFooterView = self.footView;
    
    //将控制器添加给self
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.infoTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.backgroundScrollView addSubview:self.infoTableView];
    
    //初始化footView1
    self.footView1 = [GTQDetailTableFootView detailFootView];
    self.footView1.delegate = self;
    self.infoTableView.tableFooterView = self.footView1;
    
    //添加顶部的图片scrollView
    NSArray *arr = @[@"http://img.chengmi.com/cm/3bc2198c-c909-4698-91b2-88e00c5dff2a",
                     @"http://img.chengmi.com/cm/dba3fb4d-b5ef-4218-b976-52cba4538381",
                     @"http://img.chengmi.com/cm/934ad87f-400c-452e-9427-12a03fe9cf6e"];
    self.topScrollView = [GTQScrollHeadView scrollHeadViewWithImages:arr];
    [self.topScrollView setFrame:CGRectMake(0, 0, ScreenWidth, ScrollHeadViewHeight)];
    
    //添加顶部view用做topScrollView的父控件，因为在topScrollView内部有pageView应该在同一父控件中，方便后面做拉伸动画
    self.topView = [[UIView alloc] initWithFrame:self.topScrollView.bounds];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:self.topScrollView];
    [self.view addSubview:self.topView];
    
    //添加SelectView在View,根据scrollViewY轴的偏移量算出selectView的位置
    _selectView = [GTQSelectView selectViewWithIsShowComment:NO];
    _selectView.delegate = self;
    _selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, SelectViewHeight);
    [self.view addSubview:_selectView];
    
    //添加推荐tableView的tableHeadView
    self.tableHeadView = [GTQDetailRmdTableHeadView detailRnmdTableHeadView];
    self.rmdTableView.tableHeaderView = self.tableHeadView;
    self.tableHeadView.superNC = self.navigationController;
    
    //最上层添加收藏去去过的view,这个view很多页面都有，并且需要调用数据库判断以前时候操作过，建议封装一个专门的管理工具用来管理这个控件
    self.beenAndCollectView = [GTQBeenAndCollectView beenAndCollectView];
    CGFloat beenAndCollectViewH = 45;
    self.beenAndCollectView.frame = CGRectMake(0, ScreenHeight - beenAndCollectViewH, ScreenWidth, beenAndCollectViewH);
    [self.view addSubview:self.beenAndCollectView];
    
    //初始化地图
    [MAMapServices sharedServices].apiKey = @"2e6b9f0a88b4a79366a13ce1ee9688b8";
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    self.mapView.delegate = self;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.logoCenter = CGPointMake(ScreenWidth - self.mapView.logoSize.width + 5, 220 - self.mapView.logoSize.height);
    _mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = NO;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.906598, 116.400673) animated:YES];
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 14;
    
    //添加自定义图片
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.906598, 116.400673);
    [_mapView addAnnotation:pointAnnotation];
    self.infoTableView.tableHeaderView = self.mapView;
}

//设置导航条
- (void)setupNavigationItem {
    //初始化山寨导航条
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.naviView.backgroundColor = GTQGolbalGreen;
    self.naviView.alpha = 0.0;
    [self.view addSubview:self.naviView];
    
    self.navBar = [GTQDetailNavBar customNavBarWithTitle:@"维尼的小熊最爱吃烧烤和火锅" subTitle:@"Cooper&Looper" andImage:@"index_navigation_nearby"];
    self.navBar.frame = self.naviView.frame;
    self.navBar.delegate = self;
    [self.view addSubview:self.navBar];
}

//这里计算相当繁琐 耐心慢慢来吧
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rmdTableView || scrollView == self.infoTableView) {//说明是tableView在滚动
        
        //记录当前展示的是那个tableView
        self.showingTableView = (UITableView *)scrollView;
        
        //记录出上一次滑动的距离，因为是在tableView的contentInset中偏移的ScrollHeadViewHeight，所以都得加回来
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat seleOffsetY = offsetY - self.scrollY;
        self.scrollY = offsetY;
        
        //修改顶部的scrollHeadView位置 并且通知scrollHeadView内的控件也修改位置
        CGRect headRect = self.topView.frame;
        headRect.origin.y -= seleOffsetY;
        self.topView.frame = headRect;
        
        
        //根据偏移量算出alpha的值,渐隐,当偏移量大于-180开始计算消失的值
        CGFloat startF = -180;
        //初始的偏移量Y值为 顶部俩个控件的高度
        CGFloat initY = SelectViewHeight + ScrollHeadViewHeight;
        //缺少的那一段渐变Y值
        CGFloat lackY = initY + startF;
        //自定义导航条高度
        CGFloat naviH = 64;
        
        //渐隐alpha值
        CGFloat alphaScaleHide = 1 - (offsetY + initY- lackY) / (initY- naviH - SelectViewHeight - lackY);
        //渐现alpha值
        CGFloat alphaScaleShow = (offsetY + initY - lackY) /  (initY - naviH - SelectViewHeight - lackY) ;
        
        if (alphaScaleShow >= 0.98) {
            //显示导航条
            [UIView animateWithDuration:0.04 animations:^{
                self.naviView.alpha = 1;
            }];
        } else {
            self.naviView.alpha = 0;
        }
        self.topScrollView.naviView.alpha = alphaScaleShow;
        
        //渐渐隐藏副标题和小图片
        [self.navBar updateAlpha:alphaScaleHide];
//        self.subTitleLabel.alpha = alphaScaleHide;
//        self.smallImageView.alpha = alphaScaleHide;
        
        /* 这段代码很有深意啊。。最开始是直接用偏移量算的，但是回来的时候速度比较快时偏移量会偏度很大
         然后就悲剧了。换了好多方法。。最后才开窍T——T,这一段我会在blog里面详细描述我用的各种错误的方法
         用了KVO监听偏移量的值,切换了selectView的父控件，切换tableview的headView。。。
         */
        if (offsetY >= -(naviH + SelectViewHeight)) {
            self.selectView.frame = CGRectMake(0, naviH, ScreenWidth, SelectViewHeight);
        } else {
            self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), ScreenWidth, SelectViewHeight);
        }
        
        CGFloat scaleTopView = 1 - (offsetY + SelectViewHeight + ScrollHeadViewHeight) / 100;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        
        //算出头部的变形 这里的动画不是很准确，好的动画是一点一点试出来了  这里可能还需要配合锚点来进行动画,关于这种动画我会在以后单开一个项目配合blog来讲解的 这里这就不细调了
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView );
        CGFloat ty = (scaleTopView - 1) * ScrollHeadViewHeight;
        self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.2);
        
        //记录selectViewY轴的偏移量,这个是用来计算每次切换tableView，让新出来的tableView总是在头部用的，
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        
        if (selectViewOffsetY != -ScrollHeadViewHeight && selectViewOffsetY <= 0) {
            
            if (scrollView == self.rmdTableView) {
                
                self.infoTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
            } else {
                
                self.rmdTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
            }
        }
        
    } else {
        //说明是backgroundScrollView在滚动
        
        CGFloat selectViewOffsetY = self.selectView.frame.origin.y - ScrollHeadViewHeight;
        //让新出来的tableView的contentOffset正好卡在selectView的头上,还是有bug
        if (selectViewOffsetY != -ScrollHeadViewHeight && selectViewOffsetY <= 0) {
            
            if (self.showingTableView == self.rmdTableView) {
                
                self.infoTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
            } else {
                
                self.rmdTableView.contentOffset = CGPointMake(0, -245 - selectViewOffsetY);
                
            }
        }
        
        CGFloat offsetX = self.backgroundScrollView.contentOffset.x;
        NSInteger index = offsetX / ScreenWidth;
        
        CGFloat seleOffsetX = offsetX - self.scrollX;
        self.scrollX = offsetX;
        
        //根据scrollViewX偏移量算出顶部selectViewline的位置
        if (seleOffsetX > 0 && offsetX / ScreenWidth >= (0.5 + index)) {
            [self.selectView lineToIndex:index + 1];
        } else if (seleOffsetX < 0 && offsetX / ScreenWidth <= (0.5 + index)) {
            [self.selectView lineToIndex:index];
        }
    }
}


#pragma mark - GTQDetailNavBarDelegate
//返回上个控制器
- (void)detailNavBarBackButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)detailNavBarSharedButtonClick:(UIButton *)sender {
    GTQUnLoginView *view = [GTQUnLoginView unLoginView];
    [view showUnLoginViewToView:self.view];
}

#pragma mark - UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rmdTableView) {
        //推荐tableView
        return 109;
    } else {
        //信息tableVIew
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是哪一个tableView，最多会同时拥有3个tableView，这里就不写第三种情况了，3中建议其他俩个交给另外俩个控制器来管理
    if (tableView == self.rmdTableView) {
        //推荐tableView
        GTQRmdCellModel *rmdCellModel = self.rmdDatas[indexPath.row];
        NSString *ch = rmdCellModel.ch;
        if (ch) {
            return rmdCellModel.cellHeight;
        } else {
            return 348;
        }
        
    } else {
        //信息tableVIew
        GTQInfoModel *model = self.infoDatas[indexPath.row];
        
        return model.cellHeight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.rmdTableView) {
        //推荐tableView
        
        return self.rmdDatas.count;
    } else {
        //信息tableVIew
        return self.infoDatas.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rmdTableView) {
        GTQRmdCellModel *rmdCellModel = self.rmdDatas[indexPath.row];
        NSString *ch = rmdCellModel.ch;
        if (ch) {
            return [GTQRmdTextCell cellWithTabelView:tableView rmdCellModel:rmdCellModel];
        } else {
            return [GTQRmdPictureCell cellWithTabelView:tableView identifier:@"pictureCell" rmdPicModel:rmdCellModel];
        }
    }
    
    GTQInfoCell *cell = [GTQInfoCell infoCellWithTableView:tableView];
    cell.model = self.infoDatas[indexPath.row];
    if (self.infoDatas.count - 1 == indexPath.row) {
        cell.lineView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.rmdTableView) {
        return;
    } else if (indexPath.row == 0) {
        //地图
        GTQMapViewController *mapVC = [[GTQMapViewController alloc] init];
        [self.navigationController pushViewController:mapVC animated:YES];
        
    } else if (indexPath.row == 1) {
        GTQInfoModel *model = self.infoDatas[indexPath.row];
        //打电话
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择要播的电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:model.title otherButtonTitles:model.subTitle, nil];
        [self.actionSheet showInView:self.view];
    }
}

#pragma mark - WNXSelectViewDelegate选择条的代理方法
- (void)selectView:(GTQSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    switch (to) {
        case 0:
            self.showingTableView = self.rmdTableView;
            break;
        case 1:
            self.showingTableView = self.infoTableView;
            break;
        default:
            break;
    }
    
    //根据点击的按钮计算出backgroundScrollView的内容偏移量
    CGFloat offsetX = to * ScreenWidth;
    CGPoint scrPoint = self.backgroundScrollView.contentOffset;
    scrPoint.x = offsetX;
    //默认滚动速度有点慢 加速了下
    [UIView animateWithDuration:0.3 animations:^{
        [self.backgroundScrollView setContentOffset:scrPoint];
    }];
    
}

//当滑动scrollView切换tableView时通知
- (void)selectView:(GTQSelectView *)selectView didChangeSelectedView:(NSInteger)to
{
    if (to == 0) {
        self.showingTableView = self.rmdTableView;
    } else if (to == 1) {
        self.showingTableView = self.infoTableView;
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //不是取消按钮
    if (buttonIndex != actionSheet.numberOfButtons - 1) {
        UIApplication *app = [UIApplication sharedApplication];
        //这里只有写了两种情况,实际是应该遍历服务器返回的数据,然后判断和buttonIndex
        GTQInfoModel *model = self.infoDatas[1];
        NSString *phoneNum = buttonIndex == 0 ? model.title : model.subTitle;
        [app openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]]];
    }
    
    actionSheet = nil;
}

#pragma mark - mapView代理
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"map_activity"];
        //设置中⼼心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

#pragma WNXDetailFootViewDelegate 底部收藏用户的点击事件
- (void)detailFootViewDidClick:(GTQDetailTableFootView *)footView index:(NSInteger)index
{
    //在项目中的判断应该判断是否是点击的最后一个按钮,因为可能没有那么多收藏用户,根据收藏用户的人数来判断,这里模型写的固定的 没考虑那么多,实际的数据是服务器返回的数据应该考虑的更为全面
    if (index != 5) {
        //这里应该同时将收藏用户的模型传过去
        GTQUserInfosViewController *useInfo = [[GTQUserInfosViewController alloc] init];
        [self.navigationController pushViewController:useInfo animated:YES];
    } else {
        
    }
    
}


- (void)dealloc
{
    DNSLog(@"Detail被销毁了");
    [self.mapView clearDisk];
}



@end
