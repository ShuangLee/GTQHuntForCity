//
//  GTQHomeModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  首页数据模型

#import <Foundation/Foundation.h>
@class GTQHomeCellModel;

@interface GTQHomeModel : NSObject
//headView的颜色
@property (nonatomic, copy) NSString *color;
/** headView的title */
@property (nonatomic, copy) NSString *tag_name;
/** headView的subTitle */
@property (nonatomic, copy) NSString *section_count;
/** cell模型 */
@property (nonatomic, strong) NSArray *body;

//初始化方法
+ (instancetype)homeModelWithDict:(NSDictionary *)dict;
@end
