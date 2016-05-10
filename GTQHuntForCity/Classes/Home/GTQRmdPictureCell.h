//
//  GTQRmdPictureCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQRmdCellModel.h"

@interface GTQRmdPictureCell : UITableViewCell
@property (nonatomic, strong) GTQRmdCellModel *model;

+ (instancetype)cellWithTabelView:(UITableView *)tableView identifier:(NSString *)identifier  rmdPicModel:(GTQRmdCellModel *)model;
@end
