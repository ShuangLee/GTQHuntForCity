//
//  UIBarButtonItem+quickInit.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (quickInit)

/**
 *  根据2张图片快速创建一个UIBarButtonItem，可点击高亮图片
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

/**
 *  根据图片快速创建一个UIBarButtonItem，返回小号barButtonItem
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 *  根据图片快速创建一个UIBarButtonItem，返回大号barButtonItem
 */
+ (UIBarButtonItem *)createBarButtonItemWithBigImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 *根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

/**
 *根据文字快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
