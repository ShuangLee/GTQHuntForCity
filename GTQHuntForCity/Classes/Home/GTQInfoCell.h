//
//  GTQInfoCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQInfoModel.h"

@interface GTQInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *corImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;


/** 数据模型 */
@property (nonatomic, strong) GTQInfoModel *model;

+ (instancetype)infoCellWithTableView:(UITableView *)tableView;
@end
