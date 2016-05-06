//
//  GTQFoundCollectionViewCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQFoundCellModel.h"
@class GTQFoundCollectionViewCell;

@protocol GTQFoundCollectionViewCellDelegate <NSObject>

@optional
/** cell被点击了 */
- (void)foundCollectionViewCellDidSelected:(GTQFoundCollectionViewCell *)cell;

@end

@interface GTQFoundCollectionViewCell : UICollectionViewCell
/** 便利构造方法 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath idetifier:(NSString *)identifier;

@property (nonatomic, weak) id <GTQFoundCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) GTQFoundCellModel *foundModel;
@end
