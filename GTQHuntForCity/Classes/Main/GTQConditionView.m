//
//  GTQConditionView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  选择查询条件的View (分类，地区，排序，地图)

#import "GTQConditionView.h"
#import "GTQMenuButton.h"

//选择查询条件的的初始透明度
static const CGFloat GTQConditionViewAlpha = 0.8;
//button切换的时间
static const CGFloat GTQConditionViewDuration = 0.1;

@interface GTQConditionView ()
//分割线
@property (nonatomic, strong) UIView        *line1;
@property (nonatomic, strong) UIView        *line2;
@property (nonatomic, strong) UIView        *line3;
/// 记录选择的那个条件
@property (nonatomic, weak  ) GTQMenuButton *selectedBtn;

/** 分类按钮 */
@property (nonatomic, strong) GTQMenuButton *classifyBtn;
/** 地区按钮 */
@property (nonatomic, strong) GTQMenuButton *areaBtn;
/** 排序按钮 */
@property (nonatomic, strong) GTQMenuButton *sortBtn;
/** 地图按钮 */
@property (nonatomic, strong) GTQMenuButton *mapBtn;

/** 底部的view用来添加按钮和前四个按钮的 为了区分开listBtn */
@property (nonatomic, strong) UIView        *bottomView;
/** 列表按钮，当bottomView隐藏时显示出来 和bottomView在同一个父控件中 */
@property (nonatomic, strong) GTQMenuButton *listBtn;

@end

@implementation GTQConditionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupView];
}

//初始化
- (void)setupView {
    //需要注意层级的关系
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    
    //最底部的View
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = RGBCOLOR(50, 50, 50);
    self.bottomView.alpha = GTQConditionViewAlpha;
    [self addSubview:self.bottomView];
    
    //列表按钮
    _listBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    _listBtn.tag = GTQConditionButtonTypeList;
    self.listBtn.layer.masksToBounds = YES;
    [_listBtn setTitle:@"列表" forState:UIControlStateNormal];
    [_listBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_listBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_listBtn setBackgroundColor:RGBCOLOR(50, 50, 50)];
    _listBtn.alpha = 0;//默认隐藏
    [self addSubview:self.listBtn];
    
    //添加选择条件按钮
    self.classifyBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    self.areaBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    self.sortBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    self.mapBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    //添加子控件
    [self addBtnWith:self.classifyBtn tag:GTQConditionButtonTypeClassify title:@"分类"];
    [self addBtnWith:self.areaBtn tag:GTQConditionButtonTypeArea title:@"地区"];
    [self addBtnWith:self.sortBtn tag:GTQConditionButtonTypeSort title:@"排序"];
    [self addBtnWith:self.mapBtn tag:GTQConditionButtonTypeMap title:@"地图"];
    
    //添加分割线
    self.line1 = [[UIView alloc] init];
    [self addLineWith:self.line1];
    self.line2 = [[UIView alloc] init];
    [self addLineWith:self.line2];
    self.line3 = [[UIView alloc] init];
    [self addLineWith:self.line3];

}

//添加btn
- (void)addBtnWith:(GTQMenuButton *)btn tag:(NSInteger)tag title:(NSString *)title
{
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"selectBtn"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:btn];
}

//添加分割线
- (void)addLineWith:(UIView *)line
{
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.8;
    [self.bottomView addSubview:line];
}

//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    //设置view的属性
    CGFloat H = self.bounds.size.height;
    CGFloat W = self.bounds.size.width;
    
    CGFloat cornerRadius = (H > W ? W : H) * 0.1;
    self.layer.cornerRadius = cornerRadius;
    self.listBtn.layer.cornerRadius = cornerRadius;
    
    CGFloat btnW = W / 4;
    CGFloat btnH = H;
    CGFloat lineH = H * 0.4;
    CGFloat lineY = H * 0.3;
    
    self.bottomView.frame = self.bounds;
    
    self.classifyBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.line1.frame = CGRectMake(btnW, lineY, 1, lineH);
    
    self.areaBtn.frame = CGRectMake(btnW, 0, btnW, btnH);
    self.line2.frame = CGRectMake(2 * btnW, lineY, 1, lineH);
    
    self.sortBtn.frame = CGRectMake(2 * btnW, 0, btnW, btnH);
    self.line3.frame = CGRectMake(3 * btnW, lineY, 1, lineH);
    
    self.mapBtn.frame = CGRectMake(3 * btnW, 0, btnW, btnH);
    
    self.listBtn.frame = self.mapBtn.frame;
}

//点击事件
- (void)btnClick:(GTQMenuButton *)sender {
    if (sender.tag == GTQConditionButtonTypeClassify) {
        self.line1.hidden = YES;
        self.line2.hidden = NO;
        self.line3.hidden = NO;
    } else if (sender.tag == GTQConditionButtonTypeArea) {
        self.line1.hidden = YES;
        self.line2.hidden = YES;
        self.line3.hidden = NO;
    } else if (sender.tag == GTQConditionButtonTypeSort) {
        self.line1.hidden = NO;
        self.line2.hidden = YES;
        self.line3.hidden = YES;
    } else if (sender.tag == GTQConditionButtonTypeMap) {
        self.line1.hidden = NO;
        self.line2.hidden = NO;
        self.line3.hidden = NO;
    }
    
    if (sender.tag != GTQConditionButtonTypeMap && sender.tag != GTQConditionButtonTypeList) {
        if (self.selectedBtn != sender) {
            //设置按钮选中状态
            self.selectedBtn.selected = NO;
            sender.selected = YES;
            self.selectedBtn = sender;
            
            //通知代理 第一种情况 前面3个按钮替换选择
            if ([self.delegate respondsToSelector:@selector(conditionView:didButtonClickFrom:to:)]) {
                [self.delegate conditionView:self didButtonClickFrom:self.selectedBtn.tag to:sender.tag];
            }
            
        } else {
            //点击的是同一个按钮，则取消选中
            [self cancelSelectedAllButton];
            //通知代理 第二种情况  选择了同样的按钮,取消选中
            if ([self.delegate respondsToSelector:@selector(conditionViewCancelSelectButton:)]) {
                [self.delegate conditionViewCancelSelectButton:self];
            }
        }
    } else if (sender.tag == GTQConditionButtonTypeMap) {
        //通知代理 第三种情况 选择了地图按钮
        if ([self.delegate respondsToSelector:@selector(conditionViewdidSelectedMap:)]) {
            [self.delegate conditionViewdidSelectedMap:self];
        }
        
        [self cancelSelectedAllButton];
        
        //隐藏bottomview，显示列表按钮
        [UIView animateWithDuration:GTQConditionViewDuration animations:^{
            //隐藏底部bottomView
            self.bottomView.alpha = 0;
            //显示列表按钮
            self.listBtn.alpha = GTQConditionViewAlpha;
        }];
        
    } else {
        //通知代理 第四种情况 列表按钮被点击了
        if ([self.delegate respondsToSelector:@selector(conditionViewdidSelectedList:)]) {
            [self.delegate conditionViewdidSelectedList:self];
        }
        //隐藏列表按钮，显示其他按钮
        [UIView animateWithDuration:GTQConditionViewDuration animations:^{
            self.bottomView.alpha = GTQConditionViewAlpha;
            self.listBtn.alpha = 0;
        }];
    }
}

//取消选中的按钮
- (void)cancelSelectedAllButton
{
    //取消当前选择按钮的选择状态
    self.selectedBtn.selected = NO;
    //清空临时按钮记录
    self.selectedBtn = nil;
    //显示竖线
    [self showAllLine];
}

//显示所有的分割线
- (void)showAllLine
{
    self.line1.hidden = NO;
    self.line2.hidden = NO;
    self.line3.hidden = NO;
}

@end
