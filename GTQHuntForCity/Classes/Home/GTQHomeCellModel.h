//
//  GTQHomeCellModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//  cell数据模型

#import <Foundation/Foundation.h>

@interface GTQHomeCellModel : NSObject
/** cellTitle */
@property (nonatomic, copy) NSString *section_title;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/** 赞👍次数 */
@property (nonatomic, copy) NSString *fav_count;
/** 位置名称 */
@property (nonatomic, copy) NSString *poi_name;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;
@end
