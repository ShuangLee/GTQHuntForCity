//
//  UILabel+GTQLabel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "UILabel+GTQLabel.h"

@implementation UILabel (GTQLabel)
/*
 *  快速创建指定字体大小和颜色的label
 *  默认剧中显示
 */
+ (UILabel *)createLabel:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end
