//
//  GTQPromptView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTQPromptView : UIView
//显示提醒view
- (void)showPromptViewToView:(UIView *)superView;
//隐藏
- (void)hidePromptViewToView;

+ (instancetype)promptView;
@end
