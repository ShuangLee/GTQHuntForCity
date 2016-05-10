//
//  GTQScrollHeadView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  顶部轮播图

#import <UIKit/UIKit.h>

@interface GTQScrollHeadView : UIScrollView
//代替系统的导航条
@property (nonatomic, strong) UIView *naviView;

/**
 *  便利构造方法
 */
+ (instancetype)scrollHeadViewWithImages:(NSArray *)images;
@end
