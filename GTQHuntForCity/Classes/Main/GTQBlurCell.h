//
//  GTQBlurCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQFoundCellModel.h"

@interface GTQBlurCell : UICollectionViewCell
/** 直接用found的模型 */
@property (nonatomic, strong) GTQFoundCellModel *model;

+ (instancetype)blurCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;
@end
