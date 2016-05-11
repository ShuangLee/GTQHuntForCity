//
//  GTQMessageModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQMessageModel.h"
#import <MJExtension.h>

@implementation GTQMessageModel
+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    GTQMessageModel *model = [[self alloc] init];
    [model mj_setKeyValues:dict];
    
    return model;
}
@end
