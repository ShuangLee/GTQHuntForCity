//
//  GTQFoundHeaderModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQFoundHeaderModel.h"

@implementation GTQFoundHeaderModel
//模型便利构造方法
+ (instancetype)foundHeaderModelWihtDict:(NSDictionary *)dict
{
    GTQFoundHeaderModel *model = [[GTQFoundHeaderModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
