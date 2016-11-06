//
//  DWIndicatorHUD.m
//  DWHUD
//
//  Created by Wicky on 16/11/2.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWIndicatorHUD.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDConstant.h"
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
        CGRect frame = hud.textLabel.frame;
        frame.origin = CGPointMake(MARGIN, 50);
        hud.textLabel.frame = frame;
        [hud addSubview:hud.textLabel];
    }
}

@end

@implementation DWIndicatorHUD

+(instancetype)showErrorWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showErrorWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showErrorWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createCrossComponentWithFrame:CGRectMake(0, 0, 40, 40)];
    CAShapeLayer * cross = maker.component;
    cross.strokeColor = [UIColor whiteColor].CGColor;
    
    return [DWIndicatorHUD showIndicator:cross withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showCompleteWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showCompleteWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showCompleteWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createTickComponentWithFrame:CGRectMake(0, 0, 40, 40)];
    CAShapeLayer * tick = maker.component;
    tick.strokeColor = [UIColor whiteColor].CGColor;
    
    return [DWIndicatorHUD showIndicator:tick withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showExclamationWithMessage:(NSString *)msg
{
    return [DWIndicatorHUD showExclamationWithMessage:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showExclamationWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createExclamationComponentWithFrame:CGRectMake(0, 0, 40, 40) strokeColor:[UIColor whiteColor]];
    
    return [DWIndicatorHUD showIndicator:maker.component withAnimation:maker.animation msg:msg needRing:YES toView:view hideOnTouchInside:hideOnTouchInside];
}

+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg  needRing:(BOOL)needRing toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    CALayer * layer = needRing?[DWIndicatorHUD createRingForLayer:indicator]:indicator;
    DWIndicatorHUD * hud = [DWIndicatorHUD createIndicatorHUDWithIndicator:layer indicatorAnimation:animaiton message:msg view:view];
    hud.hideOnTouchInside = hideOnTouchInside;
    hud.hideOnTouchOutside = NO;
    return hud;
}

+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg
{
    return [DWIndicatorHUD showIndicator:indicator withAnimation:animaiton msg:msg needRing:YES toView:APPRootView hideOnTouchInside:NO];
}

#pragma mark ---工具方法---
+(instancetype)createIndicatorHUDWithIndicator:(CALayer *)indicator indicatorAnimation:(DWAnimation *)animation message:(NSString *)msg view:(UIView *)view
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
        indicatorFrm = CGRectMake(0, 0, lbSz.width + MARGIN * 2, lbSz.height + 50 + MARGIN);
    }
    
    DWHUDIndicatorLayout * layout = [[DWHUDIndicatorLayout alloc] init];
    
    DWIndicatorHUD * hud = [DWIndicatorHUD createBasicHUDWithFrame:indicatorFrm layout:layout view:view];
    
    hud.indicator = indicator;
    if (comp) {
        hud.textLabel = comp.component;
        hud.textLabel.textColor = [UIColor whiteColor];
        hud.textLabel.backgroundColor = [UIColor clearColor];
    }
    [hud show];
    if (animation) {
        [animation start];
    }
    return hud;
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

///点击时隐藏的实现
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.hideOnTouchInside) {
        [self hide];
    }
}


@end
