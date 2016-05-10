//
//  GTQRmdCellModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQRmdCellModel : NSObject
//文字
@property (nonatomic, copy) NSString *ch;
//图片地址str
@property (nonatomic, copy) NSString *pic;

/** 记录文字cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)rmdCellModelWithDict:(NSDictionary *)dict;
@end
