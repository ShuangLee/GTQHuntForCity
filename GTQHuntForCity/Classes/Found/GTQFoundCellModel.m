//
//  GTQFoundCellModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQFoundCellModel.h"

@implementation GTQFoundCellModel
//模型便利构造方法
+ (instancetype)foundCellModelWihtDict:(NSDictionary *)dict
{
    GTQFoundCellModel *model = [[GTQFoundCellModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
