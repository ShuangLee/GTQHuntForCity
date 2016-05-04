//
//  UILabel+GTQLabel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GTQLabel)
// 快速创建指定字体大小和颜色的label
+ (UILabel *)createLabel:(UIColor *)color fontSize:(CGFloat)fontSize;
@end
