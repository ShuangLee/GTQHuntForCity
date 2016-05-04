//
//  GTQLeftMenuView.h
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

//LeftView按钮类型 标示
typedef NS_ENUM(NSInteger, GTQLeftButtonType) {
    GTQLeftButtonTypeHome = 0,
    GTQLeftButtonTypeFound,
    GTQLeftButtonTypeIcon,
    GTQLeftButtonTypeSina,
    GTQLeftButtonTypeWeixin,
    GTQLeftButtonTypeMessage,
    GTQLeftButtonTypeSetting
};

@protocol GTQLeftMenuViewDelegate <NSObject>

@optional
//左边按钮被点击时调用
- (void)leftMenuViewButtonClickFrom:(GTQLeftButtonType)fromIndex to:(GTQLeftButtonType)toIndex;

@end

@interface GTQLeftMenuView : UIView
@property (nonatomic, weak) id <GTQLeftMenuViewDelegate> delegate;

- (void)coverIsRemove;
@end
