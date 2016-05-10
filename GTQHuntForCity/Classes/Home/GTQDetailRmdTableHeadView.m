//
//  GTQDetailRmdTableHeadView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQDetailRmdTableHeadView.h"
#import "GTQUserInfosViewController.h"

@interface GTQDetailRmdTableHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *authorIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation GTQDetailRmdTableHeadView
- (void)awakeFromNib
{
    //设置作者名字的颜色
    self.authorNameLabel.textColor = GTQGolbalGreen;
    //设置头像羽化半径
    self.authorIconImageView.layer.masksToBounds = YES;
    self.authorIconImageView.layer.cornerRadius = self.authorIconImageView.bounds.size.width * 0.5;
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
}

+ (instancetype)detailRnmdTableHeadView
{
    GTQDetailRmdTableHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"GTQDetailRmdTableHeadView" owner:nil options:nil] lastObject];
    
    return view;
}

- (void)viewClick
{
    //拿到当前的控制器,这个view在正常的时候会在创建后拿到数据模型，所以可以直接推到下一个界面，展示作者的详情
    
    GTQUserInfosViewController *user = [[GTQUserInfosViewController alloc] init];
    
    [self.superNC pushViewController:user animated:YES];
}

@end
