//
//  GTQDetailTableFootView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTQDetailTableFootView;

@protocol GTQDetailTableFootViewDelegate <NSObject>

@optional
//点击事件
- (void)detailFootViewDidClick:(GTQDetailTableFootView *)footView index:(NSInteger)index;

@end

@interface GTQDetailTableFootView : UIView
@property(nonatomic, assign) id <GTQDetailTableFootViewDelegate> delegate;

+ (instancetype)detailFootView;//应该传入模型的
@end
