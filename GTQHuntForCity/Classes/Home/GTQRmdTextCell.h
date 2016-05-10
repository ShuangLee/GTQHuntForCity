//
//  GTQRmdTextCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  用户的详细资料view

#import <UIKit/UIKit.h>
@class GTQRmdCellModel;

@interface GTQRmdTextCell : UITableViewCell
@property (nonatomic, strong) GTQRmdCellModel *model;

+ (instancetype)cellWithTabelView:(UITableView *)tableView rmdCellModel:(GTQRmdCellModel *)rmdCellMode;
@end
