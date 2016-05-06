//
//  GTQFoundViewLayout.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQFoundViewLayout.h"

@implementation GTQFoundViewLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat itemW = 100.0;
    CGFloat itemH = 150;
    
    //cell的大小
    self.itemSize = CGSizeMake(itemW, itemH);
    //最小左右间距
    self.minimumInteritemSpacing = 0;
    //最小上下间距
    self.minimumLineSpacing = 20;
    //每个headView的大小
    self.headerReferenceSize = CGSizeMake(ScreenWidth, 30);
    //内边距
    CGFloat marginLR = (ScreenWidth - 3 * itemW) / 4;
    self.sectionInset = UIEdgeInsetsMake(20, marginLR, 20, marginLR);
}
@end
