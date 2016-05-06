//
//  GTQPrefixHeader.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/3.
//  Copyright © 2016年 Ls. All rights reserved.
//
#ifdef __OBJC__

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "UIBarButtonItem+quickInit.h"
#import "UIColor+GTQColor.h"
#import "UILabel+GTQLabel.h"

//全局的绿色主题
#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define GTQGolbalGreen RGBCOLOR(33, 197, 180)

//抽屉顶部距离 底部一样
#define GTQScaleTopMargin 35
//抽屉拉出来右边剩余比例
#define GTQZoomScaleRight 0.14
//推荐cell的高度
#define GTQRmdCellHeight 210.0
//推荐headView的高度
#define GTQRmdHeadViewHeight 60.0

#pragma clang diagnostic ignored "-W#warnings"

//判断系统版本号是否是iOS8以上
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#pragma mark - shortcuts

#ifdef DEBUG //|| TESTCASE
# define GTQLog(format, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define GTQLog(format, ...)
#endif

//日志输出宏
#define BASE_LOG(cls,sel) NSLog(@"%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error) NSLog(@"error:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),error)
#define BASE_INFO_LOG(cls,sel,info) NSLog(@"Info:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),info)

//日志输出函数
#ifdef DEBUG
#define BASE_LOG_FUN BASE_LOG([self class], _cmd)
#define BASE_ERROR_FUN(error) BASE_ERROR_LOG([self class], _cmd, error)
#define BASE_INFO_FUN(info) BASE_INFO_LOG([self class], _cmd, info)
#else
#define BASE_LOG_FUN()
#define BASE_ERROR_FUN(error)
#define BASE_INFO_FUN(info)
#endif


#ifdef  DEBUG
#define DNSLog(...);    NSLog(__VA_ARGS__);
#define DNSLogMethod    NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
#define DNSLogPoint(p)  NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)   NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)   NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

#define D_START         startTime=CFAbsoluteTimeGetCurrent();
#define D_END           DNSLog(@"[%s] %@ %f seconds", class_getName([self class]), NSStringFromSelector(_cmd), CFAbsoluteTimeGetCurrent() - startTime );
#else
#define DNSLog(...);    // NSLog(__VA_ARGS__);
#define DNSLogMethod    // NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd) );
#define DNSLogPoint(p)  // NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)   // NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)   // NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

#define D_START         // CFAbsoluteTime startTime=CFAbsoluteTimeGetCurrent();
#define D_END           // DNSLog(@"New %f seconds", CFAbsoluteTimeGetCurrent() - startTime );
#endif



//设备类型判断
#define IsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain ([[UIScreen mainScreen] scale] >= 2.0)
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWidth, ScreenHeight))
#define ScreenMinLength (MIN(ScreenWidth, ScreenHeight))

#define IsiPhone4 (IsiPhone && ScreenMaxLength < 568.0)
#define IsiPhone5 (IsiPhone && ScreenMaxLength == 568.0)
#define IsiPhone6 (IsiPhone && ScreenMaxLength == 667.0)
#define IsiPhone6P (IsiPhone && ScreenMaxLength == 736.0)

//判断系统是否大于等于v
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


//表示释放对象，并且将该对象赋值为nil
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


// Release a CoreFoundation object safely.检测对象是否为nil，如果不为nil释放对象，最后赋值为nil。
#define RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }


#define HFAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]]

////////////////////////////////////////////////////////////////////////////////

#pragma mark - common functions

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

////////////////////////////////////////////////////////////////////////////////

#pragma mark - iphone 5 detection functions
#define SCREEN_HEIGHT_OF_IPHONE5 568


#define is4InchScreen() ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)

#define Iphone4ch  (is4InchScreen() ? 10 :  100)

////////////////////////////////////////////////////////////////////////////////

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////////////////////////////////////////////////////////////////////////////////
#define PADICTIONARY_VALUE_NAME(a,b) [NSDictionary dictionaryWithObjectsAndKeys:a,@"value",b,@"name",nil]

#define AppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// 判断是否越狱
#define IS_JailBreak            system("ls") == 0 ? YES : NO

// 机器语言
#define GTQApplicationLanguage   [[NSUserDefaults standardUserDefaults] \
objectForKey:@"AppleLanguages"]                                    \
objectAtIndex : 0];

// ios版本
#define IOSBaseVersion8 8.0
#define IOSBaseVersion7 7.0
#define IOSBaseVersion6 6.0

#define IOSVersion          [[[UIDevice currentDevice] systemVersion] floatValue]
#define NEW(CLASS_NAME)  [[CLASS_NAME alloc]init]
#define GTQAlert(fmt, ...)   \
{                                       \
UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:fmt,##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] ; \
[alert1 show];               \
}

#define GTQAlert_T_M_BT(t, m, bt) \
{                                                     \
UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:t message:m delegate:nil cancelButtonTitle:bt otherButtonTitles:nil] ; [alert1 show]; \
}


//其他常量
#define AnimationSecond  1.0
#define NavBarHeight     44
#define NavBarHeight7    64
#define LocationDistance 100

#endif
