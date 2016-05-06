//
//  UIImage+Size.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
/*
 * 根据传入的宽度生成一张图片
 * 按照图片的宽高比来压缩以前的图片
 * :param: width 制定宽度
 */
- (UIImage *)imageWithScaleByWidth:(CGFloat)width;

//修改image的大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

// 控件截屏
+ (UIImage *)imageWithCaputureView:(UIView *)view;

@end
