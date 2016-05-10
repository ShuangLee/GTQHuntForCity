//
//  GTQSearchHeadView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTQSearchHeadView : UITableViewHeaderFooterView
/** headView的文字lable */
@property (nonatomic, strong) UILabel *headTextLabel;

+ (instancetype)headView;
@end
