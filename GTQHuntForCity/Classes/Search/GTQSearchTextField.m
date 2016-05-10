//
//  GTQSearchTextField.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSearchTextField.h"

@implementation GTQSearchTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.placeholder = @"请输入搜索内容";
    self.font = [UIFont systemFontOfSize:16];
    
    UIImage *image = [UIImage imageNamed:@"GroupCell"];
    self.background = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    //设置文边框左边专属View
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.bounds = CGRectMake(0, 0, 35, 35);
    //        leftView.contentMode = UIViewContentModeCenter;
    
    leftView.image = [UIImage imageNamed:@"searchm"];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
