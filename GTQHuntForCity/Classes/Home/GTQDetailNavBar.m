//
//  GTQDetailNavBar.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  详情页的导航条

#import "GTQDetailNavBar.h"

@interface GTQDetailNavBar ()

/** 返回按钮 */
@property (nonatomic, strong) UIButton                   *backBtn;
/** 分享按钮 */
@property (nonatomic, strong) UIButton                   *sharedBtn;
/** 导航条的title */
@property (nonatomic, strong) UILabel                    *titleLabel;
/** 导航条下边的副标题 */
@property (nonatomic, strong) UILabel                    *subTitleLabel;
/** 副标题旁边的小图片 */
@property (nonatomic, strong) UIImageView                *smallImageView;

@end

@implementation GTQDetailNavBar

/**
 *  便利构造方法
 */
+ (instancetype)customNavBarWithTitle:(NSString *)title subTitle:(NSString *)subTitle andImage:(NSString *)imageUrl {
    GTQDetailNavBar *navBar = [[self alloc] init];
    navBar.title = title;
    navBar.subTitle = subTitle;
    navBar.imageUrl = imageUrl;
    return navBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //添加返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    
    //分享按钮
    self.sharedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sharedBtn setImage:[UIImage imageNamed:@"btn_share_normal"] forState:UIControlStateNormal];
    [self.sharedBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sharedBtn];
    
    //添加导航条上的大文字
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    //添加导航条下面的小图片
    self.smallImageView = [[UIImageView alloc] init];
    [self addSubview:self.smallImageView];
    
    //添加副标题
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.subTitleLabel];
    
    //布局子控件
    self.backBtn.frame = CGRectMake(5, 30, 25, 25);
    self.sharedBtn.frame = CGRectMake(ScreenWidth - 36, 34, 26, 17);
    [self.titleLabel setFrame:CGRectMake(30, 32, ScreenWidth - 35 - 50, 25)];
    self.smallImageView.frame = CGRectMake(30, 60, 14, 18);
    self.subTitleLabel.frame = CGRectMake(52, 60, ScreenWidth - 180, 20);
}

- (void)updateAlpha:(CGFloat)alpha {
    self.subTitleLabel.alpha = alpha;
    self.smallImageView.alpha = alpha;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    self.subTitleLabel.text = subTitle;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    //可设置网络图片
    self.smallImageView.image = [UIImage imageNamed:imageUrl];
}

#pragma mark - 通知代理
- (void)back:(UIButton *)sender {
    //因为是必须实现的，所以不用判断delegate有没有实现方法
    [self.delegate detailNavBarBackButtonClick:sender];
}

- (void)share:(UIButton *)sender {
    [self.delegate detailNavBarSharedButtonClick:sender];
}


@end
