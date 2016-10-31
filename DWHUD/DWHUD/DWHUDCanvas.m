//
//  DWHUDCanvas.m
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"
#import "UIColor+DWColorUtils.h"
#import "DWHUDConstant.h"
#import "DWAnimation.h"
@interface DWHUDCanvas ()

@property (nonatomic ,strong) UIView * backView;

@end

@implementation DWHUDCanvas
@synthesize maskBackViewColor = _maskBackViewColor;
-(instancetype)initWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layout = layout;
        self.hidden = YES;
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
        [newSuperview addSubview:self.backView];
        self.backView.frame = newSuperview.bounds;
        if (self.maskBackViewColor) {
            self.backView.backgroundColor = self.maskBackViewColor.alphaWith(0.5);
        }
        else
        {
            self.backView.backgroundColor = [UIColor blackColor].alphaWith(0.5);
        }
    }
    else if (self.interceptOutsideUserInteraction)
    {
        [newSuperview addSubview:self.backView];
        self.backView.frame = newSuperview.bounds;
        self.backView.backgroundColor = [UIColor clearColor];
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
            if (!self.backView.superview) {
                [self.superview insertSubview:self.backView belowSubview:self];
                self.backView.frame = self.superview.bounds;
                if (self.maskBackViewColor) {
                    self.backView.backgroundColor = self.maskBackViewColor.alphaWith(0.5);
                }
                else
                {
                    self.backView.backgroundColor = [UIColor blackColor].alphaWith(0.5);
                }
            }
        }
    }
}

-(void)setInterceptOutsideUserInteraction:(BOOL)interceptOutsideUserInteraction
{
    _interceptOutsideUserInteraction = interceptOutsideUserInteraction;
    if (!self.maskBackView && interceptOutsideUserInteraction) {
        if (self.superview) {
            if (!self.backView.superview) {
                [self.superview insertSubview:self.backView belowSubview:self];
                self.backView.frame = self.superview.bounds;
                self.backView.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

-(void)show
{
///回调layout布局
    [self.layout willShowTheHUD];
    if (self.maskBackView || self.interceptOutsideUserInteraction) {
        self.backView.hidden = NO;
    }
    if (self.showAnimation && self.showAnimation.duration > 0 ) {
        [self.showAnimation start];
    }
    else
    {
        [self showAction];
    }
}

-(void)showAction
{
    ///展示
    self.hidden = NO;
    
    ///展示回调
    if (self.didShowBlock) {
        WEAKSELF;
        self.didShowBlock(weakSelf);
    }
}

-(void)hide
{
    if (self.hideAnimation && self.hideAnimation.duration > 0) {
        [self.hideAnimation start];
    }
    else
    {
        [self hideAction];
    }
}

-(void)hideAction
{
    ///隐藏
    self.hidden = YES;
    if (self.maskBackView) {
        self.backView.hidden = YES;
    }
    ///回调layout布局
    [self.layout didHideTheHUD];
    
    ///隐藏回调
    if (self.didHideBlock) {
        WEAKSELF;
        self.didHideBlock(weakSelf);
    }
    
    ///隐藏时移除
    if (self.removeOnHide) {
        [self removeFromSuperview];
    }
}

-(void)setLayout:(DWHUDLayout *)layout
{
    _layout = layout;
    layout.canvas = self;
}

-(void)setMaskBackViewColor:(UIColor *)maskBackViewColor
{
    if (self.maskBackView) {
        _maskBackViewColor = maskBackViewColor;
        self.backView.backgroundColor = maskBackViewColor.alphaWith(0.5);
    }
}

-(UIColor *)maskBackViewColor
{
    if (self.maskBackView) {
        return _maskBackViewColor;
    }
    return nil;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.hidden = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(backViewTapAction)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(void)backViewTapAction
{
    if (self.hideOnTouchOutside) {
        [self hide];
    }
}

-(void)setShowAnimation:(DWAnimation *)showAnimation
{
    WEAKSELF;
    showAnimation.completion = ^(DWAnimation * ani){
        [weakSelf showAction];
    };
    _showAnimation = showAnimation;
}

-(void)setHideAnimation:(DWAnimation *)hideAnimation
{
    WEAKSELF;
    hideAnimation.completion = ^(DWAnimation * ani){
        [weakSelf hideAction];
    };
    _hideAnimation = hideAnimation;
}
@end
