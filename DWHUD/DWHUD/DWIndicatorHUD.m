//
//  DWIndicatorHUD.m
//  DWHUD
//
//  Created by Wicky on 16/11/2.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWIndicatorHUD.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDAnimationManager.h"
#define MARGIN 5

@interface DWHUDIndicatorLayout : DWHUDLayout

@end

@implementation DWHUDIndicatorLayout

-(void)layoutDWHUDComponents
{
    DWIndicatorHUD * hud = self.canvas;
    CGFloat width = hud.bounds.size.width;
    hud.indicator.position = CGPointMake(width / 2.0, 20 + MARGIN);
    [hud.layer addSublayer:hud.indicator];
    if (hud.textLabel) {
        hud.frame = CGRectMake(0, 0, hud.bounds.size.width, hud.textLabel.bounds.size.height + 50 + (hud.textLabelOffset?hud.textLabelOffset:MARGIN));
        hud.center = CGPointMake(hud.superview.bounds.size.width / 2.0, hud.superview.bounds.size.height/ 2.0);
        CGRect frame = hud.textLabel.frame;
        frame.origin = CGPointMake(hud.bounds.size.width / 2.0 - hud.textLabel.bounds.size.width / 2.0, 45 + (hud.textLabelOffset?hud.textLabelOffset:MARGIN));
        hud.textLabel.frame = frame;
        [hud addSubview:hud.textLabel];
    }
}

@end

@interface DWIndicatorHUD ()

///HUD组件动画
@property (nonatomic ,strong) DWAnimation * compAnimation;

@end

@implementation DWIndicatorHUD

-(instancetype)initCompleteWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createTickComponentWithFrame:CGRectMake(0, 0, 40, 40)];
    CAShapeLayer * tick = maker.component;
    tick.strokeColor = [UIColor whiteColor].CGColor;
    return [self initIndicator:tick withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showCompleteWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showCompleteWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showCompleteWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWIndicatorHUD * hud = [[DWIndicatorHUD alloc] initCompleteWithMessage:msg toView:view hideOnTouchInside:hideOnTouchInside];
    [hud setTwoAnimationForHUD:hud];
    [hud show];
    return hud;
}

-(instancetype)initErrorWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createCrossComponentWithFrame:CGRectMake(0, 0, 40, 40)];
    CAShapeLayer * cross = maker.component;
    cross.strokeColor = [UIColor whiteColor].CGColor;
    return [self initIndicator:cross withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showErrorWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showErrorWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showErrorWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWIndicatorHUD * hud = [[DWIndicatorHUD alloc] initErrorWithMessage:msg toView:view hideOnTouchInside:hideOnTouchInside];
    [hud setTwoAnimationForHUD:hud];
    [hud show];
    return hud;
}

-(instancetype)initExclamationWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createExclamationComponentWithFrame:CGRectMake(0, 0, 40, 40) strokeColor:[UIColor whiteColor]];
    return [self initIndicator:maker.component withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showExclamationWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showExclamationWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showExclamationWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWIndicatorHUD * hud = [[DWIndicatorHUD alloc] initExclamationWithMessage:msg toView:view hideOnTouchInside:hideOnTouchInside];
    [hud setTwoAnimationForHUD:hud];
    [hud show];
    return hud;
}

-(instancetype)initIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg needRing:(BOOL)needRing toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    CALayer * layer = needRing?[DWIndicatorHUD createRingForLayer:indicator]:indicator;
    self = [self initIndicatorHUDWithIndicator:layer indicatorAnimation:animaiton message:msg view:view];
    self.hideOnTouchInside = hideOnTouchInside;
    self.hideOnTouchOutside = NO;
    return self;
}

+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg needRing:(BOOL)needRing toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWIndicatorHUD * hud = [[DWIndicatorHUD alloc] initIndicator:indicator withAnimation:animaiton msg:msg needRing:needRing toView:view hideOnTouchInside:hideOnTouchInside];
    [hud setTwoAnimationForHUD:hud];
    [hud show];
    return hud;
}

-(void)setTwoAnimationForHUD:(DWIndicatorHUD *)hud
{
    if (hud.showAnimation) {
        __weak typeof(hud) weakHUD = hud;
        hud.showAnimation.completion = ^(DWAnimation * ani){
            if (weakHUD.compAnimation) {
                [weakHUD.compAnimation start];
            }
        };
    }
    else
    {
        if (hud.compAnimation) {
            [hud.compAnimation start];
        }
    }
}

+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg
{
    return [DWIndicatorHUD showIndicator:indicator withAnimation:animaiton msg:msg needRing:YES toView:APPRootView hideOnTouchInside:NO];
}

#pragma mark ---工具方法---
-(instancetype)initIndicatorHUDWithIndicator:(CALayer *)indicator indicatorAnimation:(DWAnimation *)animation message:(NSString *)msg view:(UIView *)view
{
    DWHUDComponentMaker * comp = nil;
    if (msg.length) {
        CGFloat limitLength = [UIScreen mainScreen].bounds.size.width * 0.5;
        comp = [DWHUDComponentMaker createLabelComponentWithString:msg font:[UIFont systemFontOfSize:13] numberOfLines:0 autoresize:YES limitSize:CGSizeMake(limitLength, limitLength)];
    }
    CGRect indicatorFrm = CGRectMake(0, 0, 50, 50);
    if (comp) {
        UILabel * label = comp.component;
        CGSize lbSz = label.bounds.size;
        CGFloat tempWidth = lbSz.width + MARGIN * 2;
        indicatorFrm = CGRectMake(0, 0, tempWidth > 50 ? tempWidth : 50, lbSz.height + 50 + MARGIN);
    }
    
    DWHUDIndicatorLayout * layout = [[DWHUDIndicatorLayout alloc] init];
    
    self = [super initBasicHUDWithFrame:indicatorFrm layout:layout view:view];
    if (self) {
        self.compAnimation = animation;
        self.showType = DWHUDAnimatoinTypeFallIn;
        self.hideType = DWHUDAnimatoinTypeFallOut;
        self.indicator = indicator;
        if (comp) {
            self.textLabel = comp.component;
            self.textLabel.textColor = [UIColor whiteColor];
            self.textLabel.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

///为一个layer创建一个圆环
+(CAShapeLayer *)createRingForLayer:(CALayer *)layer
{
    DWHUDComponentMaker * ring = [DWHUDComponentMaker createRingComponentWithRadius:20];
    CAShapeLayer * ringLayer = ring.component;
    ringLayer.strokeColor = [UIColor whiteColor].CGColor;
    ringLayer.sublayerTransform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
    layer.position = CGPointMake(20, 20);
    [ringLayer addSublayer:layer];
    return ringLayer;
}

-(void)setTextLabelOffset:(CGFloat)textLabelOffset
{
    if (self.textLabel) {
        _textLabelOffset = textLabelOffset;
        [self layoutIfNeeded];
    }
}

-(void)setShowType:(DWHUDAnimatoinType)showType
{
    if (showType == DWHUDAnimatoinTypeFallIn) {
        _showType = showType;
        self.showAnimation = [DWHUDAnimationManager createFallInAnimationWithView:self];
    }
    else if (showType == DWHUDAnimatoinTypeNone)
    {
        _showType = showType;
        self.showAnimation = nil;
    }
}

-(void)setHideType:(DWHUDAnimatoinType)hideType
{
    if (hideType == DWHUDAnimatoinTypeFallOut) {
        _hideType = hideType;
        self.hideAnimation = [DWHUDAnimationManager createFallOutAnimationWithView:self];
    }
    else if (hideType == DWHUDAnimatoinTypeNone)
    {
        _hideType = hideType;
        self.hideAnimation = nil;
    }
}
@end
