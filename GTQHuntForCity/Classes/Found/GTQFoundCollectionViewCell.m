//
//  GTQFoundCollectionViewCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQFoundCollectionViewCell.h"

@interface GTQFoundCollectionViewCell ()

/** 图片按钮 */
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
/** 大标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 小标题 */
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation GTQFoundCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath idetifier:(NSString *)identifier{
    //取出cell，如果复用队列为空，系统自动创建GTQFoundCollectionViewCell
    GTQFoundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    //给按钮添加点击事件，按钮完全拦截整个cell的点击事件
    [self.iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)iconButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(foundCollectionViewCellDidSelected:)]) {
        [self.delegate foundCollectionViewCellDidSelected:self];
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    /*  拦截事件响应者，不论触发了cell中的哪个控件都交给iconButton来响应 */
    // 1.判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    
    // 2. 判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    
    return self.iconButton;
}

//重写模型的set方法
- (void)setFoundModel:(GTQFoundCellModel *)foundModel
{
    _foundModel = foundModel;
    
    [self.iconButton setImage:[UIImage imageNamed:foundModel.icon] forState:UIControlStateNormal];
    self.titleLabel.text = foundModel.title;
    self.subTitleLabel.text = foundModel.subTitle;
}


@end
