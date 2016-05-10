//
//  GTQRmdPictureCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQRmdPictureCell.h"
#import "UIImageView+WebCache.h"

@interface GTQRmdPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@end

@implementation GTQRmdPictureCell

- (void)awakeFromNib {
    // Initialization code
    self.picImageView.contentMode = UIViewContentModeScaleToFill;
    self.contentView.clipsToBounds = YES;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView identifier:(NSString *)identifier rmdPicModel:(GTQRmdCellModel *)model {
    GTQRmdPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    
    cell.model = model;
    return cell;
}

- (void)setModel:(GTQRmdCellModel *)model {
    _model = model;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"cover_headerView"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
