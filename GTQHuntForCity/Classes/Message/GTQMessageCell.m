//
//  GTQMessageCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQMessageCell.h"
#import "GTQMessageModel.h"

@interface GTQMessageCell ()
/** 日期 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 删除按钮 */
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
/** 绿色小箭头 */
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
/** 消息文字 */
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
/** 底部3个箭头文字 */
@property (weak, nonatomic) IBOutlet UILabel *bottomArrowLabel;
/** 背景 */
@property (weak, nonatomic) IBOutlet UIView *whiteBackGround;

@end

@implementation GTQMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView NSIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"message";
    
    GTQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    
    //记录当前indexpath
    cell.indexPath = indexPath;
    
    return cell;

}

//重新model的set方法
- (void)setModel:(GTQMessageModel *)model
{
    //添加约束
    _model = model;
    self.dateLabel.text = model.date;
    self.messageLabel.text = model.message;
    
    [self layoutIfNeeded];
    
    [self.whiteBackGround updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomArrowLabel.bottom).offset(10);
    }];
    [self layoutIfNeeded];
    
    //    DNSLog(@"%f", self.whiteBackgroundView.bounds.size.height);
    model.cellHeight = CGRectGetMaxY(self.bottomArrowLabel.frame) + 30;
    //    DNSLog(@"%f", model.cellHeight);
    
}

- (void)awakeFromNib {
    // Initialization code
    [self setupView];
}

//设置子视图
- (void)setupView {
    self.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背景圆角效果
    self.whiteBackGround.layer.masksToBounds = YES;
    self.whiteBackGround.layer.cornerRadius = 5;
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whiteBackgroundViewDidClcik)];
    [self.whiteBackGround addGestureRecognizer:tap];
    
    //默认隐藏删除按钮
    self.deleteButton.hidden = YES;
    self.deleteButton.alpha = 0;
}

//删除按钮点击
- (IBAction)deleteBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageCell:didClcikDeleteBtnAtIndexPath:)]) {
        [self.delegate messageCell:self didClcikDeleteBtnAtIndexPath:self.indexPath];
    }
}

//cell被点击时通知代理点击了那一个cell
- (void)whiteBackgroundViewDidClcik
{
    if ([self.delegate respondsToSelector:@selector(messageCell:didClickAtIndexPath:)]) {
        [self.delegate messageCell:self didClickAtIndexPath:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


/// 开始编辑
- (void)startEdit {
    self.deleteButton.hidden = NO;
    //隐藏绿色小箭头 显示删除按钮
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.alpha = 0;
        self.deleteButton.alpha = 1;
    } completion:^(BOOL finished) {
        self.arrowImageView.hidden = YES;
        self.deleteButton.enabled = YES;
    }];
}

/// 停止编辑
- (void)endEdit {
    self.deleteButton.enabled = NO;
    self.arrowImageView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.alpha = 1;
        self.deleteButton.alpha = 0;
    } completion:^(BOOL finished) {
        self.deleteButton.hidden = YES;
    }];
}

@end
