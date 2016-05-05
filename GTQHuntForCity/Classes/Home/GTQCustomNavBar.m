//
//  GTQCustomNavBar.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQCustomNavBar.h"
#import "GTQCustomNavTitleView.h"
#import "UIButton+GTQButton.h"
#import "GTQHomeModel.h"

@interface GTQCustomNavBar ()
/** 导航条titileView */
@property (nonatomic, strong) GTQCustomNavTitleView *titleview;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 分享按钮 */
@property (nonatomic, strong) UIButton *sharedBtn;
@end

@implementation GTQCustomNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //添加返回按钮
    self.backBtn = [UIButton createBtnWithImage:@"back"];
    [self.backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    
    //添加分享按钮
    self.sharedBtn = [UIButton createBtnWithImage:@"btn_share_normal"];
    [_sharedBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sharedBtn];
    
    //添加titleview
    self.titleview = [[GTQCustomNavTitleView alloc] init];
    [self addSubview:_titleview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    self.backBtn.frame = CGRectMake(10, 27, 25, 25);
    self.sharedBtn.frame = CGRectMake(w - 34, 31, 24, 18);
    
    CGFloat titleW = w * 0.7;
    CGFloat titleX = (w - titleW) / 2;
    self.titleview.frame = CGRectMake(titleX, h * 0.25, titleW, h * 0.8);
}

- (void)setHeadModel:(GTQHomeModel *)headModel {
    _headModel = headModel;
    self.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
    [self.titleview setTitle:headModel.tag_name subTitle:headModel.section_count];
}

#pragma mark - 通知代理
- (void)back:(UIButton *)sender {
    //因为是必须实现的，所以不用判断delegate有没有实现方法
    [self.delegate customNavBarBackButtonClick:sender];
}

- (void)share:(UIButton *)sender {
    [self.delegate customNavBarSharedButtonClick:sender];
}
@end
