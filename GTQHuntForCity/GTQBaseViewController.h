//
//  GTQBaseViewController.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//  控制器基类

#import <UIKit/UIKit.h>
typedef void (^coverDidRemove)();

@interface GTQBaseViewController : UIViewController
//** 遮盖按钮 */
@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, strong) coverDidRemove coverDidRomove;

@property (nonatomic, assign) BOOL isScale;

- (void)coverClick;

/** 点击缩放按钮 */
- (void)rightBarButtonItemClick;
@end
