//
//  GTQDetailModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQDetailModel.h"
#import <MJExtension.h>

@implementation GTQDetailModel
+ (instancetype)detailModelWith:(NSDictionary *)dict
{
    GTQDetailModel *detail = [[self alloc] init];
    
    [detail mj_setKeyValues:dict];
    
    return detail;
}
@end
