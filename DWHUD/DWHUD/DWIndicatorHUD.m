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
        frame.origin = CGPointMake(MARGIN, 50 + MARGIN);
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
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createCrossComponentWithFrame:CGRectMake(0, 0, 50, 50)];
    CAShapeLayer * layer = maker.component;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    DWIndicatorHUD * hud = [DWIndicatorHUD createIndicatorHUDWithIndicator:layer indicatorAnimation:maker.animation message:msg view:view];
    hud.hideOnTouchInside = hideOnTouchInside;
    hud.hideOnTouchOutside = NO;
    return hud;
}

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
        indicatorFrm = CGRectMake(0, 0, lbSz.width + MARGIN * 2, lbSz.height + 50 + MARGIN * 2);
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
    [animation start];
    return hud;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.hideOnTouchInside) {
        [self hide];
    }
}


@end
