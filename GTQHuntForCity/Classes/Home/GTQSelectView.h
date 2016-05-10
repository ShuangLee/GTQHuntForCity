//
//  GTQSelectView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//  用来处理详情页选着哪一个tableView的View，有两种情况，如果服务器返回的数据中评论不为为空，就有3个tableView
//  如果返回的评论是空就显示俩个view

#import <UIKit/UIKit.h>

@class GTQSelectView;

@protocol GTQSelectViewDelegate <NSObject>

@optional
//当按钮点击时通知代理
- (void)selectView:(GTQSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)selectView:(GTQSelectView *)selectView didChangeSelectedView:(NSInteger)to;

@end

@interface GTQSelectView : UIView
/** 用来确定是否显示评论列表的 默认是NO，只显示俩个button, 如果是YES就显示3个button */
@property(nonatomic, assign) BOOL isShowComment;

@property(nonatomic, weak) id <GTQSelectViewDelegate> delegate;

+ (instancetype)selectViewWithIsShowComment:(BOOL)isShowComment;

//提供给外部一个可以滑动底部line的方法
- (void)lineToIndex:(NSInteger)index;
@end
