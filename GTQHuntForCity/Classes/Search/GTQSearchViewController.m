//
//  GTQSearchViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSearchViewController.h"
#import "GTQSearchTextField.h"
#import "GTQSearchHistoryCell.h"
#import "GTQSearchHeadView.h"
#import "HotSearchCell.h"

//历史搜索记录的文件路径
#define GTQSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]

@interface GTQSearchViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
/** 搜索文本框 */
@property (nonatomic, weak) GTQSearchTextField *searchTF;
/** 搜索的tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 搜索的数据 */
@property (nonatomic, strong) NSMutableArray *datas;
/** 历史搜索数据 */
@property (nonatomic, strong) NSMutableArray *hisDatas;
/** 热门数据模型 */
@property (nonatomic, strong) NSArray *hotDatas;
@end

@implementation GTQSearchViewController

- (NSMutableArray *)hisDatas {
    if (_hisDatas == nil) {
        DNSLog(@"%@",GTQSearchHistoryPath);
        _hisDatas = [NSMutableArray arrayWithContentsOfFile:GTQSearchHistoryPath];
        if (_hisDatas == nil) {
            _hisDatas = [NSMutableArray arrayWithObjects:@"常山赵子龙",@"马孟起", nil];
        }
    }
    
    return _hisDatas;
}

- (NSArray *)hotDatas {
    if (_hotDatas == nil) {
        _hotDatas = @[@"张翼德",@"马孟起",@"常山赵子龙",@"关云长"];
    }
    
    return _hotDatas;
}

/** 模拟数据,懒加载方法 */
- (NSMutableArray *)datas {
    //datas需要根据输入数据而变化 所以每次都来重新获取数据
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        
        //搜索数据
        if (self.hisDatas.count) {
            [_datas addObject:self.hisDatas];
        }
        //热门数据
        //热点搜索，估计服务器每次返回四个字符串
        [_datas addObject:self.hotDatas];
    } else {
        if (self.hisDatas.count) {
            [_datas removeAllObjects];//清除数据
            
            //重新添加
            [_datas addObject:self.hisDatas];
            [_datas addObject:self.hotDatas];
        }
    }
    
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航条内容
    [self setupNavigationItem];
    
    //初始化UI
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //文本框获取焦点
    [self.searchTF becomeFirstResponder];
}

- (void)setupNavigationItem {
    //搜索框
    GTQSearchTextField *searchField = [[GTQSearchTextField alloc] init];
    CGFloat w = ScreenWidth * 0.7;
    searchField.frame = CGRectMake(0, 0, w, 30);
    searchField.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchField];
    self.searchTF = searchField;
    
    //取消按钮
    UIBarButtonItem *rightItem = [UIBarButtonItem createBarButtonItemWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)back
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITextFieldDelegate
//监听手机键盘点击搜索的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //判断是否有输入,有值的话将新的字符串添加到datas[0]中并且重新写入文件，发送网络请求
    /* 发送请求 */
    if (textField.text.length) {
        for (NSString *text in self.hisDatas) {
            if ([text isEqualToString:textField.text]) {
                return YES;
            }
        }
        
        [self.hisDatas insertObject:textField.text atIndex:0];
        [self.hisDatas writeToFile:GTQSearchHistoryPath atomically:YES];
        
        [self.tableView reloadData];
        textField.text = @"";
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //点击屏幕搜索框失去焦点
    [self.searchTF resignFirstResponder];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.datas.count == 2) {
        if (section == 0) {
            return [self.datas[0] count];
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datas.count == 2 && indexPath.section == 0 && self.hisDatas.count) {
        GTQSearchHistoryCell *cell = [GTQSearchHistoryCell historyCellWithTableView:tableView IndexPath:indexPath atNSMutableArr:self.hisDatas];
        cell.historyTextLabel.text = self.datas[0][indexPath.row];
        return cell;
    } else {
        //这里就一个cell 不用注册了
        HotSearchCell *cell = [HotSearchCell hotCellWithHotDatas:self.hotDatas];
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //注册head的方法和cell差不多
    GTQSearchHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    
    if (head == nil) {
        head = [GTQSearchHeadView headView];
    }
    
    if (self.datas.count == 2) {
        if (section == 0) {
            head.headTextLabel.text = @"历史";
            return head;
        } else {
            head.headTextLabel.text = @"热门";
            return head;
        }
    } else {
        head.headTextLabel.text = @"热门";
        return head;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
@end
