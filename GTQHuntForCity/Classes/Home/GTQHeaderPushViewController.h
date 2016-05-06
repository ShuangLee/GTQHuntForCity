//
//  GTQHeaderPushViewController.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQShowViewController.h"
@class GTQHomeModel;

@interface GTQHeaderPushViewController : GTQShowViewController
//headModel用来设置导航条的属性，在推荐页面push来时直接把headModel正向传值传来,需要注意这里重写set方法赋值的时
//当前控制器的navigationController是空的,无法修改导航条的属性
@property (nonatomic, strong) GTQHomeModel *headModel;
@end
