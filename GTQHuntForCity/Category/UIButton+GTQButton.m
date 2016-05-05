//
//  UIButton+GTQButton.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "UIButton+GTQButton.h"

@implementation UIButton (GTQButton)

// 快速创建指定图片的btn
+ (UIButton *)createBtnWithImage:(NSString *)imageName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];    
    return btn;
}

// 快速创建指定图文的btn
+ (UIButton *)createBtnWithImage:(NSString *)imageName title:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    return btn;
}
@end
