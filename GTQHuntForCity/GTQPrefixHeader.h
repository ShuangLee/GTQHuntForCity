//
//  GTQPrefixHeader.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//

#ifndef GTQPrefixHeader_h
#define GTQPrefixHeader_h
#import "Masonry.h"
#import "UIBarButtonItem+quickInit.h"
#import "UIColor+GTQColor.h"

//全局的绿色主题
#define GTQColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define GTQGolbalGreen WNXColor(33, 197, 180)

//抽屉顶部距离 底部一样
#define WNXScaleTopMargin 35
//app的宽度
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
//app的高度
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//抽屉拉出来右边剩余比例
#define GTQZoomScaleRight 0.14

#pragma clang diagnostic ignored "-W#warnings"

//判断系统版本号是否是iOS8以上
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#endif /* GTQPrefixHeader_h */
