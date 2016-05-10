//
//  GTQRmdTextCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  推荐tableView的文字cell,图片cell的高度是固定大小的,这个cell的高度是需要根据内容大小在计算的

#import "GTQRmdTextCell.h"
#import "GTQRmdCellModel.h"

@interface GTQRmdTextCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 显示文字 */
@property (nonatomic, copy) NSString *labelText;
@end

@implementation GTQRmdTextCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    // 设置label每一行文字的最大宽度
    // 为了保证计算出来的数值 跟 真正显示出来的效果 一致
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 30;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


+ (instancetype)cellWithTabelView:(UITableView *)tableView rmdCellModel:(GTQRmdCellModel *)rmdCellMode;
{
    static NSString *identifier = @"rmdTextCell";
    
    GTQRmdTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    cell.model = rmdCellMode;
    
    return cell;
}

- (void)setModel:(GTQRmdCellModel *)model
{
    _model = model;
    self.titleLabel.text = model.ch;
    [self layoutIfNeeded];
    model.cellHeight = CGRectGetMaxY(self.titleLabel.frame) + 10;
}

- (void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    self.titleLabel.text = labelText;
}

@end
