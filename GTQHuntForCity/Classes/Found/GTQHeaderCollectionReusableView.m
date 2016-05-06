//
//  GTQHeaderCollectionReusableView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQHeaderCollectionReusableView.h"

@interface GTQHeaderCollectionReusableView ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation GTQHeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//便利构造器
+ (instancetype)headerWithCollectionView:(UICollectionView *)collectionView forIndexpath:(NSIndexPath *)indexPath identifier:(NSString *)identifier model:(GTQFoundHeaderModel *)model {
    GTQHeaderCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    view.headModel = model;
    return view;
}

- (void)setHeadModel:(GTQFoundHeaderModel *)headModel {
    _headModel = headModel;
    self.textLabel.text = headModel.cagetory;
    self.lineView.hidden = headModel.isHide;
}

- (void)setupUI {
    self.textLabel = [UILabel createLabel:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];
    [self addSubview:self.textLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.hidden = YES;
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.lineView.alpha = 0.2;
    [self addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
    
    self.lineView.frame = CGRectMake(40, 0, self.bounds.size.width - 80, 1);
}
@end
