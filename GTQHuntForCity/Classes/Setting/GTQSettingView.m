//
//  GTQSettingView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/11.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSettingView.h"
#import "GTQMenuButton.h"

@interface GTQSettingView ()
@property (nonatomic, strong) GTQMenuButton *leftBtn;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation GTQSettingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    
    self.leftBtn = [GTQMenuButton buttonWithType:UIButtonTypeCustom];
    //取消按钮的可编辑状态
    self.leftBtn.enabled = NO;
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.leftBtn];
    self.rightImageView = [[UIImageView alloc] init];
    self.rightImageView.image = [UIImage imageNamed:@"register_right_arrow"];
    [self addSubview:self.rightImageView];
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textColor = [UIColor grayColor];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.hidden = YES;
    [self addSubview:self.rightLabel];
}

+ (instancetype)setingViewWihtTitle:(NSString *)title defaultImage:(NSString *)imageName
{
    GTQSettingView *setingView = [[GTQSettingView alloc] init];
    
    //有图片的就是上面的微信和新浪登陆
    if (imageName) {
        [setingView.leftBtn setTitleColor:GTQGolbalGreen forState:UIControlStateNormal];
        [setingView.leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [setingView.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        //        [setingView.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [setingView.leftBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [setingView.leftBtn setTitle:title forState:UIControlStateNormal];
    } else {
        [setingView.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [setingView.leftBtn setTitle:title forState:UIControlStateNormal];
        [setingView.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    }
    
    return setingView;
    
}

- (void)layoutSubviews
{
    //子控件布局
    [super layoutSubviews];
    
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    self.layer.cornerRadius = (W > H ? H : W) * 0.15;
    self.leftBtn.frame = CGRectMake(0, H * 0.2, W * 0.5, H * 0.6);
    
    
    CGFloat imageH = H * 0.3;
    CGFloat imageW = 30;
    CGFloat imageX = W - 20;
    CGFloat imageY = H * 0.35;
    self.rightImageView.frame = CGRectMake(imageX, imageY, imageW * 0.3, imageH);
    
    self.rightLabel.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (void)setleftBtnLoginImage:(UIImage *)image rightLabelText:(NSString *)rightText
{
        [self.leftBtn setImage:image forState:UIControlStateNormal];
    self.rightLabel.text = rightText;
}

@end
