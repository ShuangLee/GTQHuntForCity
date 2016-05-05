//
//  GTQRmdHeaderView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTQHomeModel.h"
//  headView的复用，需要注意headView的类型为UITabelHeaderFooterView,使用和cell的复用差不多这没数据就先没用
//    GTQRmdHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headId];
//
//    if (headView == nil) {
//        headView =  [GTQRmdHeaderView headViewWith:headModel];
//    }
//   此处模拟数据 先不继承UITabelHeaderFooterView

@interface GTQRmdHeaderView : UIView
//headView的模型，重写set方法
@property (nonatomic, strong) GTQHomeModel *headModel;
//便利构造方法
+ (instancetype)headViewWith:(GTQHomeModel *)headModel;
@end
