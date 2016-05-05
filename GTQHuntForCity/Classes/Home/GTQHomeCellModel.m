//
//  GTQHomeCellModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQHomeCellModel.h"
#import <MJExtension.h>

@implementation GTQHomeCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict {
    GTQHomeCellModel *model = [[self alloc] init];
    [model mj_setKeyValues:dict];
    return model;
}
@end
