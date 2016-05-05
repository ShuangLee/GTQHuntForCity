//
//  GTQRmdTableViewCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQHomeCellModel.h"

@interface GTQRmdTableViewCell : UITableViewCell
/** cell的模型 */
@property (nonatomic, strong) GTQHomeCellModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(GTQHomeCellModel *)model;
@end
