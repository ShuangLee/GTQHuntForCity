//
//  GTQHomeModel.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQHomeModel.h"
#import <MJExtension.h>

@implementation GTQHomeModel
+ (instancetype)homeModelWithDict:(NSDictionary *)dict {
    GTQHomeModel *home = [[GTQHomeModel alloc] init];
    [home mj_setKeyValues:dict];
    return home;
}
@end
