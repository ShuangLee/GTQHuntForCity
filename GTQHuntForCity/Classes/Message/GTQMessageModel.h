//
//  GTQMessageModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQMessageModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *message;

/* cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
