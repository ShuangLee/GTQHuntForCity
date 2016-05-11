//
//  GTQHaveNoMessageView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//  没有消息时的提示图

#import "GTQHaveNoMessageView.h"

@implementation GTQHaveNoMessageView

- (void)awakeFromNib {
    self.backgroundColor = RGBCOLOR(239, 239, 244);
}

+ (instancetype)noHaveMessageView {
    GTQHaveNoMessageView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
    view.bounds = CGRectMake(0, 0, 200, 200);
    //view.frame = CGRectMake((ScreenWidth - 200) / 2, 150, 200, 200);
    return view;
}
@end
