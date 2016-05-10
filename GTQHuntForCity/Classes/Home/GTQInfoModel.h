//
//  GTQInfoModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQInfoModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL isShowImage;
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)infoModelWithDict:(NSDictionary *)dict;
@end
