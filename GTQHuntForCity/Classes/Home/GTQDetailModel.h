//
//  GTQDetailModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  详情数据模型

#import <Foundation/Foundation.h>

@interface GTQDetailModel : NSObject
/** detail列表 */
@property (nonatomic, strong) NSArray *poi_list;

/** 头部信息 */
@property (nonatomic, strong) NSDictionary *section_info;

/** 推荐tableveiw数据 */
@property (nonatomic, strong) NSArray *article_list;

+ (instancetype)detailModelWith:(NSDictionary *)dict;
@end
