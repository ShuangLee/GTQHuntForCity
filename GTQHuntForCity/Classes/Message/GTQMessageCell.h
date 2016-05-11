//
//  GTQMessageCell.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTQMessageCell, GTQMessageModel;

@protocol GTQMessageCellDelegate <NSObject>

@optional
//cell的删除按钮被点击了
- (void)messageCell:(GTQMessageCell *)cell didClcikDeleteBtnAtIndexPath:(NSIndexPath *)indexPath;

//cell被点击了 push下一级页面
- (void)messageCell:(GTQMessageCell *)cell didClickAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GTQMessageCell : UITableViewCell
/** messageCell的数据模型 */
@property (nonatomic, strong) GTQMessageModel *model;

@property (nonatomic, weak) id <GTQMessageCellDelegate> delegate;

/** 记录自己是那个一cell, 当内部删除按钮被点击或者白色框被点击时通知外部代理哪一个cell被点击了 */
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView NSIndexPath:(NSIndexPath *)indexPath;

//开始编辑,显示删除按钮
- (void)startEdit;

//结束编辑状态
- (void)endEdit;
@end
