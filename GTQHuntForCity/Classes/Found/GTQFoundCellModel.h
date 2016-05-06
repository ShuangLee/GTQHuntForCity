//
//  GTQFoundCellModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQFoundCellModel : NSObject
/** 图片名 */
@property (nonatomic, copy) NSString *icon;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 副标题 */
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)foundCellModelWihtDict:(NSDictionary *)dict;
@end
