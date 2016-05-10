//
//  GTQInfoCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQInfoCell.h"

@interface GTQInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleSecondLabel;

@end

@implementation GTQInfoCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


+ (instancetype)infoCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"infoCell";
    GTQInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setModel:(GTQInfoModel *)model
{
    _model = model;
    
    self.titleOneLabel.text = model.title;
    if (model.subTitle) {
        self.titleSecondLabel.text = model.subTitle;
    } else {
        self.titleSecondLabel.hidden = YES;
    }
    
    self.corImageView.hidden = !model.isShowImage;
    
    [self layoutIfNeeded];
    
    if (!self.titleSecondLabel.hidden) {
        model.cellHeight = CGRectGetMaxY(self.titleSecondLabel.frame) + 20;
    } else {
        model.cellHeight = CGRectGetMaxY(self.titleOneLabel.frame) + 10;
    }
    
}

@end
