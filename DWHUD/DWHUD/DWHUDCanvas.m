//
//  DWHUDCanvas.m
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@interface DWHUDCanvas ()

@property (nonatomic ,strong) UIView * backView;

@end

@implementation DWHUDCanvas

-(instancetype)initWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layout = layout;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.layout) {
        [self.layout layoutDWHUDComponents];
    }
    else
    {
        NSException *ex = [NSException exceptionWithName: @"Property Error!" reason: @"The property 'layout' can't be nil." userInfo: nil];
        @throw ex;
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.maskBackView) {
        if (!self.backView) {
            self.backView = [[UIView alloc] initWithFrame:newSuperview.bounds];
            self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        }
        [newSuperview addSubview:self.backView];
    }
}

-(void)removeFromSuperview
{
    if (self.maskBackView) {
        if (self.backView) {
            [self.backView removeFromSuperview];
        }
    }
    [super removeFromSuperview];
}

-(void)setMaskBackView:(BOOL)maskBackView
{
    _maskBackView = maskBackView;
    if (maskBackView) {
        if (self.superview) {
            if (!self.backView) {
                self.backView = [[UIView alloc] initWithFrame:self.superview.bounds];
                self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            }
            if (!self.backView.superview) {
                [self.superview insertSubview:self.backView belowSubview:self];
            }
        }
    }
}

-(void)show
{
    [self.layout willShowTheHUD];
///TODO:
//    添加展示语句
}

-(void)hide
{
///TODO:
//    添加隐藏语句
    [self.layout didHideTheHUD];
}

-(void)setLayout:(DWHUDLayout *)layout
{
    _layout = layout;
    layout.canvas = self;
}

@end
