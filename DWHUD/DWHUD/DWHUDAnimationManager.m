//
//  DWHUDAnimationManager.m
//  DWHUD
//
//  Created by Wicky on 16/11/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDAnimationManager.h"
#import "DWAnimation.h"
#import "UIView+DWAnimation.h"
@implementation DWHUDAnimationManager

+(DWAnimation *)createAnimationWithView:(UIView *)view type:(DWHUDAnimatoinType)type
{
    switch (type) {
        case DWHUDAnimatoinTypeFallIn:
            return [DWHUDAnimationManager createFallInAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeFallOut:
            return [DWHUDAnimationManager createFallOutAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeFlyIn:
            return [DWHUDAnimationManager createFlyInAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeFlyOut:
            return [DWHUDAnimationManager createFlyOutAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeZoomIn:
            return [DWHUDAnimationManager createZoomInAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeZoomOut:
            return [DWHUDAnimationManager createZoomOutAnimationWithView:view];
            break;
        default:
            return nil;
            break;
    }
}

+(DWAnimation *)createFallInAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    CGRect bounds = view.superview.bounds;
    return [view dw_CreateAnimationWithAnimationKey:@"FallInAnimation" springingType:DWAnimationSpringTypeMove beginTime:0 fromValue:PointValue(bounds.size.width / 2.0, -view.bounds.size.height / 2.0) toValue:PointValue(bounds.size.width / 2.0, bounds.size.height / 2.0) mass:1 stiffness:100 damping:10 initialVelocity:0];
}

+(DWAnimation *)createFallOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    CGRect bounds = view.superview.bounds;
    return [view dw_CreateAnimationWithKey:@"FallOutAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.moveTo(CGPointMake(bounds.size.width / 2.0, bounds.size.height + view.bounds.size.height / 2.0)).duration(0.4).install();
    }];
}

+(DWAnimation *)createFlyInAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    CGRect bounds = view.superview.bounds;
    return [view dw_CreateAnimationWithAnimationKey:@"FlyInAnimation" springingType:DWAnimationSpringTypeMove beginTime:0 fromValue:PointValue(-view.bounds.size.width / 2.0, bounds.size.height / 2.0) toValue:PointValue(bounds.size.width / 2.0, bounds.size.height / 2.0) mass:1 stiffness:100 damping:10 initialVelocity:0];
}

+(DWAnimation *)createFlyOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    CGRect bounds = view.superview.bounds;
    return [view dw_CreateAnimationWithKey:@"FlyOutAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.moveTo(CGPointMake(bounds.size.width + view.bounds.size.width / 2.0, bounds.size.height / 2.0)).duration(0.4).install();
    }];
}

+(DWAnimation *)createZoomInAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    return [view dw_CreateAnimationWithAnimationKey:@"ZoomInAnimation" springingType:DWAnimationSpringTypeScale beginTime:0 fromValue:@(0) toValue:@(1) mass:5 stiffness:500 damping:25 initialVelocity:0];
}

+(DWAnimation *)createZoomOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    return [view dw_CreateAnimationWithAnimationKey:@"ZoomOutAnimation" springingType:DWAnimationSpringTypeScale beginTime:0 fromValue:@(1) toValue:@(0) mass:5 stiffness:500 damping:100 initialVelocity:-13];
}
@end
