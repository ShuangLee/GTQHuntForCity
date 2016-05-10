//
//  GTQSelectButton.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQSelectButton.h"

@implementation GTQSelectButton

- (void)setHighlighted:(BOOL)highlighted{}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(contentRect.origin.x + 2, contentRect.origin.y + 2, contentRect.size.width - 4, contentRect.size.height - 4);
    
    return rect;
}


@end
