//
//  GTQRmdTableViewCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQRmdTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface GTQRmdTableViewCell ()
/** 背景图 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
/** 主题 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/** 赞数 */
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;

@end

@implementation GTQRmdTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = RGBCOLOR(51, 52, 53);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(GTQHomeCellModel *)model {
    static NSString *reuseId = @"recommendCell";
    GTQRmdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GTQRmdTableViewCell class]) owner:nil options:nil] lastObject];
    }
    
    //设置数据
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"ContentViewNoImages"]];
    cell.nameLabel.text = model.section_title;
    cell.addressLabel.text = model.poi_name;
    cell.praiseLabel.text = model.fav_count;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
