//
//  GTQDetailRmdTableHeadView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  用于详情页推荐tableview的headView,用来展示作者以及浏览人数的view，点击后push到作者的详情页

#import <UIKit/UIKit.h>

@interface GTQDetailRmdTableHeadView : UIView
/** 临时记录自己的导航控制器 ￥注意这儿必须用weak,如果用strong就循环引用了￥ */
@property (weak, nonatomic) UINavigationController *superNC;

+ (instancetype)detailRnmdTableHeadView;//需要传入model
@end
