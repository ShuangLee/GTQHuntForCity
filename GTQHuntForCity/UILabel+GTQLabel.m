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
 */
+ (UILabel *)createLabel:(UIColor *)color fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
@end
