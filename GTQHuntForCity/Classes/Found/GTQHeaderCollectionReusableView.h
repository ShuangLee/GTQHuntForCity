//
//  GTQHeaderCollectionReusableView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQFoundHeaderModel.h"

@interface GTQHeaderCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) GTQFoundHeaderModel *headModel;

+ (instancetype)headerWithCollectionView:(UICollectionView *)collectionView forIndexpath:(NSIndexPath *)indexPath identifier:(NSString *)identifier model:(GTQFoundHeaderModel *)model;
@end
