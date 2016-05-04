//
//  UIBarButtonItem+quickInit.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "UIBarButtonItem+quickInit.h"

@implementation UIBarButtonItem (quickInit)

/**
 *  根据2张图片快速创建一个UIBarButtonItem，可点击高亮图片
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.frame = CGRectMake(0, 0, 35, 35);//指定宽高
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //自适应宽高
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  根据图片快速创建一个UIBarButtonItem，返回大号barButtonItem
 */
+ (UIBarButtonItem *)createBarButtonItemWithBigImage:(NSString *)image target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  根据图片快速创建一个UIBarButtonItem，返回小号barButtonItem
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  根据文字快速创建一个UIBarButtonItem，自定义大小
 */

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
}

@end

