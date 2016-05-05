//
//  GTQUnLoginView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  未登录展示视图

/** 未登录view的高度 */
static const CGFloat unLoginViewHeight = 250;
/** 未登录view弹出和收起的动画时间 */
static const CGFloat unLoginViewShowHideAnimationDuration = 0.3;

#import "GTQUnLoginView.h"
#import "GTQPromptView.h"

@interface GTQUnLoginView ()
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 背部的遮盖按钮 */
@property (nonatomic, strong) UIButton *maxCoverBtn;
/** 记录父视图的bounds */
@property (nonatomic, assign) CGRect superViewBounds;

/** 提醒View */
@property (nonatomic, strong) GTQPromptView *prompView;

@end

@implementation GTQUnLoginView

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    //圆角
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.height / 2;
    
    //添加遮罩
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
}

//初始化
+ (instancetype)unLoginView {
    GTQUnLoginView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

/*
 *显示未登录view
 */
- (void)showUnLoginViewToView:(UIView *)superView {
    [superView addSubview:self.maxCoverBtn];
    
    self.superViewBounds = superView.bounds;
    
    self.frame = CGRectMake(0, superView.bounds.size.height, superView.bounds.size.width, unLoginViewHeight);
    
    [superView addSubview:self];
    
    [UIView animateWithDuration:unLoginViewShowHideAnimationDuration animations:^{
        self.frame = CGRectMake(0, superView.bounds.size.height - unLoginViewHeight, superView.bounds.size.width, unLoginViewHeight);
    }];
}

- (IBAction)sinaLoginBtnClick:(id)sender {
    [self showPromptViewToView];
}

- (IBAction)weixinLoginBtnClick:(id)sender {
    [self showPromptViewToView];
}

- (void)showPromptViewToView {
    [self.prompView hidePromptViewToView];
    self.prompView = nil;
    self.prompView = [GTQPromptView promptView];
    [_prompView showPromptViewToView:self.superview];
}

//遮盖被点击了,收回view
- (void)coverClick
{
    [UIView animateWithDuration:unLoginViewShowHideAnimationDuration animations:^{
        self.frame = CGRectMake(0, self.superViewBounds.size.height, self.superViewBounds.size.width, unLoginViewHeight);
    } completion:^(BOOL finished) {
        [self.maxCoverBtn removeFromSuperview];
        [self removeFromSuperview];
        [self.prompView hidePromptViewToView];
    }];
}

@end
