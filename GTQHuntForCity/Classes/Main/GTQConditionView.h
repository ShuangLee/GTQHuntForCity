//
//  GTQConditionView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/5.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTQMenuButton,GTQConditionView;
//选择查询按钮类型
typedef NS_ENUM(NSInteger, GTQConditionButtonType){
    GTQConditionButtonTypeClassify = 10,
    GTQConditionButtonTypeArea = 11,
    GTQConditionButtonTypeSort = 12,
    GTQConditionButtonTypeMap = 13,
    GTQConditionButtonTypeList = 14
};

@protocol GTQConditionViewDelegate <NSObject>

@optional
/** 点击前三个按钮触发代理事件 */
- (void)conditionView:(GTQConditionView *)view didButtonClickFrom:(GTQConditionButtonType)fromType to:(GTQConditionButtonType)toType;

/** 点击了地图按钮，显示地图 */
- (void)conditionViewdidSelectedMap:(GTQConditionView *)view;

/** 点击了列表按钮 移除地图View */
- (void)conditionViewdidSelectedList:(GTQConditionView *)view;

/** 取消选择按钮 */
- (void)conditionViewCancelSelectButton:(GTQConditionView *)view;

@end

@interface GTQConditionView : UIView
@property (nonatomic, weak) id <GTQConditionViewDelegate> delegate;

/**
 *  取消所有按钮的选中状态
 */
- (void)cancelSelectedAllButton;
@end
