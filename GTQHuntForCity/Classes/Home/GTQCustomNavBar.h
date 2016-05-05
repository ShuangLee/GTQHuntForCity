//
//  GTQCustomNavBar.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTQHomeModel;

@protocol GTQCustomNavBarDelegate <NSObject>

/** 返回按钮和分享按钮的点击事件 */
- (void)customNavBarBackButtonClick:(UIButton *)sender;
- (void)customNavBarSharedButtonClick:(UIButton *)sender;

@end

@interface GTQCustomNavBar : UIView
@property (nonatomic, weak) id <GTQCustomNavBarDelegate> delegate;

//根据传人的模型设置属性
@property (nonatomic, strong) GTQHomeModel *headModel;
@end
