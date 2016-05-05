//
//  GTQRmdHeaderView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQRmdHeaderView.h"

@interface GTQRmdHeaderView ()
/** 分类名 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation GTQRmdHeaderView

+ (instancetype)headViewWith:(GTQHomeModel *)headModel {
    //和cell一样可以重用
    GTQRmdHeaderView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    headView.headModel = headModel;
    return headView;
}

- (void)setHeadModel:(GTQHomeModel *)headModel {
    _headModel = headModel;
    self.titleLabel.text = headModel.tag_name;
    self.subTitleLabel.text = headModel.section_count;
    /**
     myTableViewHeaderFooterView.contentView.backgroundColor = [UIColor blackColor];
     myTableViewHeaderFooterView.backgroundView.backgroundColor = [UIColor blackColor];
     myTableViewHeaderFooterView.backgroundColor = [UIColor blackColor];
     这三种都无法改变背景色.
     */
    //正解如下, 在UITableViewHeaderFooterView子类中赋值给backgroundView属性并设置需求的背景颜色
//    self.backgroundView = ({
//        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
//        view.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
//        view;
//    });
    self.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
}

@end
