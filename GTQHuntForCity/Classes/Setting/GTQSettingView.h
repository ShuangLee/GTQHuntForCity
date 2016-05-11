//
//  GTQSettingView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/11.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
//GTQSettingView的类型
typedef NS_ENUM(NSInteger, GTQSettingViewType) {
    GTQSettingViewTypeSina = 100,    //新浪登录
    GTQSettingViewTypeWeiXin,        //微信登录
    GTQSettingViewTypeClean,         //清理缓存
    GTQSettingViewTypeFeedback,      //反馈吐槽
    GTQSettingViewTypeJudge          //五星好评
    
};
@interface GTQSettingView : UIView
+ (instancetype)setingViewWihtTitle:(NSString *)title defaultImage:(NSString *)imageName;

/** 登陆成功 设置左边按钮的图片 以及右边label的文字 */
- (void)setleftBtnLoginImage:(UIImage *)image rightLabelText:(NSString *)rightText;
@end
