//
//  GTQBeenAndCollectView.m
//  GTQHuntForCity
//
//  Created by 光头强 on 16/5/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "GTQBeenAndCollectView.h"
#import "GTQMenuButton.h"
#import "GTQUnLoginView.h"

@interface GTQBeenAndCollectView ()
@property (weak, nonatomic) IBOutlet GTQMenuButton *beenButton;
@property (weak, nonatomic) IBOutlet GTQMenuButton *collectButton;

@end

@implementation GTQBeenAndCollectView

- (void)awakeFromNib
{
    [self.beenButton addTarget:self action:@selector(beenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)beenAndCollectView
{
    GTQBeenAndCollectView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    
    return view;
}

- (void)beenButtonClick
{
    [self showPromptViewToView];
}

- (void)collectButtonClick
{
    [self showPromptViewToView];
}

- (void)showPromptViewToView
{
    GTQUnLoginView *unLogin = [GTQUnLoginView unLoginView];
    [unLogin showUnLoginViewToView:self.superview];
}

@end
