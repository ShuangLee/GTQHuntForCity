//
//  GTQRenderBlurView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTQRenderBlurView;
@protocol GTQRenderBlurViewDelegate <NSObject>

- (void)renderBlurView:(GTQRenderBlurView *)view didSelectedCellWithTitle:(NSString *)title;

//取消按钮
- (void)renderBlurViewCancelBtnClick:(GTQRenderBlurView *)view;

@end

@interface GTQRenderBlurView : UIImageView
@property (nonatomic, weak) id <GTQRenderBlurViewDelegate> delegate;

+ (instancetype)renderBlurViewWithImage:(UIImage *)image;
//隐藏模糊的view
- (void)hideBlurView;
@end
