//
//  GTQCityButton.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/4.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQCityButton.h"

@implementation GTQCityButton

- (void)setHighlighted:(BOOL)highlighted {

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //调整图片和文字的位置
    CGFloat imageX = self.bounds.size.width / 2 + 20;
    self.imageView.frame = CGRectMake(imageX, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.bounds.size.height);
    
    CGFloat titleX = self.bounds.size.width / 2 - 20;
    self.titleLabel.frame = CGRectMake(titleX, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.bounds.size.height);
}
@end
