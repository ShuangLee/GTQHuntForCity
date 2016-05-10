//
//  GTQDetailNavBar.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GTQDetailNavBarDelegate <NSObject>

/** 返回按钮和分享按钮的点击事件 */
- (void)detailNavBarBackButtonClick:(UIButton *)sender;
- (void)detailNavBarSharedButtonClick:(UIButton *)sender;

@end

@interface GTQDetailNavBar : UIView

@property (nonatomic, weak) id <GTQDetailNavBarDelegate> delegate;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSString* imageUrl;

/**
 *  便利构造方法
 */
+ (instancetype)customNavBarWithTitle:(NSString *)title subTitle:(NSString *)subTitle andImage:(NSString *)imageUrl;

- (void)updateAlpha:(CGFloat)alpha;

@end
