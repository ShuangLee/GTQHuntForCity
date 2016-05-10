//
//  GTQInfoModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQInfoModel.h"

@implementation GTQInfoModel
+ (instancetype)infoModelWithDict:(NSDictionary *)dict
{
    GTQInfoModel *model = [[self alloc] init];
    model.title = dict[@"title"];
    model.subTitle = dict[@"subTitle"];
    model.isShowImage = [dict[@"isShowImage"] integerValue];
    return model;
}
@end
