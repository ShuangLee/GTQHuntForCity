//
//  GTQShowViewController.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTQConditionView, GTQRenderBlurView;

@interface GTQShowViewController : UIViewController
/** 显示的tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 顶部的选着条件按钮的View */
@property (nonatomic, strong) GTQConditionView *conditionView;

@end
