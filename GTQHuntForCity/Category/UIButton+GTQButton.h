//
//  UIButton+GTQButton.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GTQButton)
// 指定图文btn
+ (UIButton *)createBtnWithImage:(NSString *)imageName;
// 快速创建指定图文的btn
+ (UIButton *)createBtnWithImage:(NSString *)imageName title:(NSString *)title;
@end
