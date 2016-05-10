//
//  GTQUserInfoView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTQUserInfoView : UIView
//便利构造方法
+ (instancetype)userInfoView;

//传入userInfoViewY轴滚动的距离,内部计算顶部的头像位置
- (void)userInfViewScrollOffsetY:(CGFloat)offsetY;
@end
