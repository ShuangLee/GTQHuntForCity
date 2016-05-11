//
//  GTQMessageDeleteButton.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//  消息页面点击按钮底部弹出的删除全部消息按钮

#import "GTQMessageDeleteButton.h"

@implementation GTQMessageDeleteButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    [self setBackgroundColor:GTQGolbalGreen];
    [self setTitle:@"清除全部消息" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.hidden = YES;
}

/**
 *  显示底部按钮
 */
- (void)showDeleteBtn
{
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
    }];
}

/**
 *  隐藏底部按钮
 */
- (void)hideDeleteBtn
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end
