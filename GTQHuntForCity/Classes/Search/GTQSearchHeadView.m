//
//  GTQSearchHeadView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSearchHeadView.h"

@implementation GTQSearchHeadView

+ (instancetype)headView {
    GTQSearchHeadView *headView = [[self alloc] init];
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

//添加子控件
- (void)setup {
    //设置背景颜色
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = RGBCOLOR(230, 230, 230);
        view;
    });

    //添加顶部文字label
    self.headTextLabel = [[UILabel alloc] init];
    self.headTextLabel.textColor = [UIColor lightGrayColor];
    self.headTextLabel.font = [UIFont systemFontOfSize:20];
    self.headTextLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.headTextLabel];
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新布局headView的子控件
    self.headTextLabel.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height);
}


@end
