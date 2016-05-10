//
//  GTQBaseViewController.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//  控制器基类

#import "GTQBaseViewController.h"
#import "GTQSearchViewController.h"

#define GTQScaleAnimationDuration 0.3

@interface GTQBaseViewController ()

@end

@implementation GTQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  添加导航条上的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createBarButtonItemWithImage:@"search_icon_white_6P@2x" target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createBarButtonItemWithImage:@"artcleList_btn_info_6P" target:self action:@selector(leftBarButtonItemClick)];
    self.view.backgroundColor = RGBCOLOR(239, 239, 244);
}

#pragma mark - 导航条按钮点击 
- (void)rightBarButtonItemClick {
    GTQSearchViewController *search = [[GTQSearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

/*
 抽屉的效果是通过给导航控制器的view做形变动画完成的transform的X轴的位移以及整体的缩放效果,这里由于每个导航控制器的功能一样，这里抽取了共同的特点封装了一个基类导航控制器，基类拥有点击左边的按钮完成变形和恢复的功能
 */
- (void)leftBarButtonItemClick {
    //添加遮盖,拦截用户操作
    _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _coverBtn.frame = self.navigationController.view.bounds;
    [_coverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_coverBtn];
    
    //缩放比例
    CGFloat zoomScale = (ScreenHeight - GTQScaleTopMargin * 2) / ScreenHeight;
    //X移动距离
    CGFloat moveX = ScreenWidth - ScreenWidth * GTQZoomScaleRight;
    
    [UIView animateWithDuration:GTQScaleAnimationDuration animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        //先缩放在位移会使位移缩水,正常需要moveX/zoomScale 才是正常的比例,这里感觉宽度还好就省略此步
        self.navigationController.view.transform = CGAffineTransformTranslate(transform, moveX, 0);
        //将状态改成已经缩放
        self.isScale = YES;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//cover点击
- (void)coverClick
{
    [UIView animateWithDuration:GTQScaleAnimationDuration animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
        self.isScale = NO;
        //当遮盖按钮被销毁时调用
        if (_coverDidRomove) {
            _coverDidRomove();
        }
    }];
}


@end
