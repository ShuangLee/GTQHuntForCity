//
//  HotSearchCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSearchCell : UITableViewCell
/** 热门btn的titles */
@property (nonatomic, strong) NSArray *hotDatas;

+ (instancetype)hotCellWithHotDatas:(NSArray *)hotDatas;
@end
