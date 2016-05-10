//
//  GTQSelectView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSelectView.h"
#import "GTQMenuButton.h"
#import "GTQSelectButton.h"


@interface GTQSelectView ()
/** 推荐按钮 */
@property (nonatomic, strong) GTQSelectButton *groomBtn;
/** 信息按钮 */
@property (nonatomic, strong) GTQSelectButton *infoBtn;
/** 评论按钮 */
@property (nonatomic, strong) GTQSelectButton *commentBtn;
/** 底部滑动的动画条 */
@property (nonatomic, strong) UIView *slideLineView;

//记录当前被选中的按钮
@property (nonatomic, weak) GTQSelectButton *nowSelectedBtn;
@end

@implementation GTQSelectView

+ (instancetype)selectViewWithIsShowComment:(BOOL)isShowComment {
    GTQSelectView *selectView = [[self alloc] init];
    selectView.isShowComment = isShowComment;
    
    return selectView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

//设置控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //这里需要判断下是否显示commentBtn,抓不到数据，暂时先不显示，如果需要显示就给也设置frame
    CGFloat viewH = self.bounds.size.height;
    CGFloat viewW = self.bounds.size.width;
    CGFloat btnW = viewW * 0.3;
    CGFloat btnH = viewH;
    //计算间距
    CGFloat margin = (viewW - btnW * (self.subviews.count - 1)) / self.subviews.count;
    
    self.groomBtn.frame = CGRectMake(margin, 0, btnW, btnH);
    self.infoBtn.frame = CGRectMake(2 * margin + btnW , 0, btnW, btnH);
    self.slideLineView.frame = CGRectMake(margin, viewH - 4, btnW, 4);
}

- (void)setupView {
    //背景色和阴影
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    
    //正常是需要注意图片和文字的距离，我一般在button的layoutSubViews重新布局
    self.groomBtn = [GTQSelectButton buttonWithType:UIButtonTypeCustom];
    [self addBtnToView:self.groomBtn image:[UIImage imageNamed:@"groom"] tag:0];
    self.infoBtn = [GTQSelectButton buttonWithType:UIButtonTypeCustom];
    [self addBtnToView:self.infoBtn image:[UIImage imageNamed:@"info"] tag:1];
    
    //在setIsShowComment方法中写初始化，如果需要就将这个button初始化并且添加到view上
    //[self addBtnToView:self.commentBtn image:[UIImage imageNamed:@"comment"] tag:2];
    self.slideLineView = [[UIView alloc] init];
    self.slideLineView.backgroundColor = GTQGolbalGreen;
    self.slideLineView.layer.masksToBounds = YES;
    self.slideLineView.layer.cornerRadius = 2;
    [self addSubview:self.slideLineView];
    
    [self.groomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.infoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)addBtnToView:(GTQSelectButton *)btn image:(UIImage *)image tag:(NSInteger)tag
{
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setImage:image forState:UIControlStateNormal];
    btn.tag = tag;
    [self addSubview:btn];
}

//有代理时，点击按钮
- (void)setDelegate:(id<GTQSelectViewDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:self.groomBtn];
}

#pragma mark - 按钮的Action
- (void)btnClick:(GTQSelectButton *)sender
{
    if (self.nowSelectedBtn == sender) return;
    
    //通知代理点击
    if ([self.delegate respondsToSelector:@selector(selectView:didSelectedButtonFrom:to:)]) {
        [self.delegate selectView:self didSelectedButtonFrom:self.nowSelectedBtn.tag to:sender.tag];
    }
    
    //给滑动小条做动画
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = sender.frame.origin.x;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
    self.nowSelectedBtn = sender;
}

- (void)lineToIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:0];
            }
            self.nowSelectedBtn = self.groomBtn;
            break;
        case 1:
            if ([self.delegate respondsToSelector:@selector(selectView:didChangeSelectedView:)]) {
                [self.delegate selectView:self didChangeSelectedView:1];
            }
            self.nowSelectedBtn = self.infoBtn;
            break;
        default:
            break;
    }
    
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = self.nowSelectedBtn.frame.origin.x;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
    
}

@end
