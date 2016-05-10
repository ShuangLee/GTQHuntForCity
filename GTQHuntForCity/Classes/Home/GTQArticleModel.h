//
//  GTQArticleModel.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTQArticleModel : NSObject
/** 浏览次数 */
@property (nonatomic, assign) NSInteger *viewcount;
/** 推荐tableviewcell的数据 */
@property (nonatomic, strong) NSArray *newcontent;
/** 推荐headViewtitle */
@property (nonatomic, copy) NSString *art_title;
/** 作者信息 */
@property (nonatomic, strong) NSDictionary *author_info;
@end
