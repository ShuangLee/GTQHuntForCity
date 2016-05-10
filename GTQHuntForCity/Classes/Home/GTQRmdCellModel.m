//
//  GTQRmdCellModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQRmdCellModel.h"

@implementation GTQRmdCellModel
+ (instancetype)rmdCellModelWithDict:(NSDictionary *)dict
{
    GTQRmdCellModel *cellModel = [[self alloc] init];
    cellModel.pic = dict[@"pic"];
    cellModel.ch = dict[@"ch"];
    
    return cellModel;
}

@end
