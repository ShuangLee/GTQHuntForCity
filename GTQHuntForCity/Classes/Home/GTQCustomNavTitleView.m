//
//  GTQCustomNavTitleView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  导航条上的自定义上下title

#import "GTQCustomNavTitleView.h"

@interface GTQCustomNavTitleView ()
/** 主题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 副标题 */
@property (nonatomic, strong) UILabel *subTitleLabel;
@end

@implementation GTQCustomNavTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.titleLabel = [UILabel createLabel:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:16]];
    self.subTitleLabel = [UILabel createLabel:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:13]];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
}

//重新布局view的子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    self.titleLabel.frame = CGRectMake(0, 2, w, 20);
    self.subTitleLabel.frame = CGRectMake(0, 22 , w, 20);
}

// 初始化赋值
- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
}

@end
