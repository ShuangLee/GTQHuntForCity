//
//  GTQPromptView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQPromptView.h"

@interface GTQPromptView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation GTQPromptView

- (void)awakeFromNib {
    self.layer.cornerRadius = 10;
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2;
}

+ (instancetype)promptView {
    GTQPromptView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

//显示
- (void)showPromptViewToView:(UIView *)superView {
    CGRect rect = self.bounds;
    rect.origin = CGPointMake((superView.bounds.size.width - rect.size.width) / 2, 100);
    self.frame = rect;
    self.alpha = 0;
    
    [superView addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1.0;
    }];
}

//隐藏
- (void)hidePromptViewToView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)deleteBtnClick:(id)sender {
    [self hidePromptViewToView];
}

@end
