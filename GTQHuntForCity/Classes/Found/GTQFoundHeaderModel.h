//
//  GTQFoundHeaderModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQFoundHeaderModel : NSObject
/** 分类名  */
@property (nonatomic, strong) NSString *cagetory;
/** 是否有线  */
@property (nonatomic, assign) BOOL isHide;

+ (instancetype)foundHeaderModelWihtDict:(NSDictionary *)dict;
@end
