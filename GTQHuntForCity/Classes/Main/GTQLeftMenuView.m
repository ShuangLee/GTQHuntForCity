//
//  GTQLeftMenuView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQLeftMenuView.h"
#import "GTQMenuButton.h"
#import "GTQCityButton.h"

//按钮的宽高比例
#define GTQBtnScaleForWidth 0.7
#define GTQBtnScaleForHeight 0.1

@interface GTQLeftMenuView ()

/** 城市选择 */
@property (weak, nonatomic) IBOutlet GTQCityButton *cityBtn;
/** 首页 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *homeBtn;
/** 发现 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *foundBtn;
/** 登陆 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *iconBtn;
/** 新浪登陆 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *sinaBtn;
/** 微信登陆 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *weixinBtn;
/** 消息 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *messageBtn;
/** 设置 */
@property (weak, nonatomic) IBOutlet GTQMenuButton *setingBtn;
@property (nonatomic, weak) UIButton *selectedBtn;
//参照物的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeftConstraint;

@end

@implementation GTQLeftMenuView
- (void)awakeFromNib {
    //设置citybtn
    self.cityBtn.layer.masksToBounds = YES;
    self.cityBtn.layer.cornerRadius = 8;
    [self.cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    [self.cityBtn setTitleColor:GTQGolbalGreen forState:UIControlStateNormal];
    [self.cityBtn setImage:[UIImage imageNamed:@"city_down"] forState:UIControlStateNormal];
    [self.cityBtn setImage:[UIImage imageNamed:@"city_up"] forState:UIControlStateSelected];
    [self.cityBtn addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    //给按钮添加tag值
    self.homeBtn.tag = GTQLeftButtonTypeHome;
    self.foundBtn.tag = GTQLeftButtonTypeFound;
    self.iconBtn.tag = GTQLeftButtonTypeIcon;
    self.sinaBtn.tag = GTQLeftButtonTypeSina;
    self.weixinBtn.tag = GTQLeftButtonTypeWeixin;
    self.messageBtn.tag = GTQLeftButtonTypeMessage;
    self.setingBtn.tag = GTQLeftButtonTypeSetting;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //调整按钮宽高
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    CGFloat btnW = viewWidth * GTQBtnScaleForWidth;
    CGFloat btnH = viewHeight * GTQBtnScaleForHeight;
    CGFloat btnX = (viewWidth - btnW) / 2;
    
    self.btnHeightConstraint.constant = btnH;
    self.btnWidthConstraint.constant = btnW;
    self.btnLeftConstraint.constant = btnX;
    
    [self.setingBtn layoutIfNeeded];
}

- (void)setDelegate:(id<GTQLeftMenuViewDelegate>)delegate {
    _delegate = delegate;
    [self leftBtnClick:self.homeBtn];
}


#pragma mark - BtnAction 
//leftBtn点击事件
- (IBAction)leftBtnClick:(GTQMenuButton *)sender {
    if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClickFrom:to:)]) {
        [self.delegate leftMenuViewButtonClickFrom:(GTQLeftButtonType)self.selectedBtn.tag to:(GTQLeftButtonType)sender.tag];
    }
    
    if (sender.tag != GTQLeftButtonTypeIcon && sender.tag != GTQLeftButtonTypeSina && sender.tag != GTQLeftButtonTypeWeixin) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }
    
    if (self.cityBtn.selected) {
        [self cityButtonClick:self.cityBtn];
    }

}

//cictyBtn的点击事件
- (void)cityButtonClick:(GTQCityButton *)sender {

}

- (void)coverIsRemove {
    if (self.cityBtn.selected) {
        [self cityButtonClick:self.cityBtn];
    }
}
@end
