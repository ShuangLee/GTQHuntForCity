//
//  GTQBlurCell.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQBlurCell.h"

@interface GTQBlurCell ()
/* 文字 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIButton *blurImageView;


@end

@implementation GTQBlurCell
+ (instancetype)blurCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    GTQBlurCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)setModel:(GTQFoundCellModel *)model {
    _model = model;
    [self.blurImageView setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    [self.titleLabel setText:model.title];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    /*  拦截事件响应者，不论触发了cell中的哪个控件都交给cell来响应 */
    // 1.判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    
    // 2. 判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    
    return self;
}
@end
