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
#import "UIBezierPath+DWPathUtils.h"
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
        case DWHUDAnimatoinTypeRotateIn:
            return [DWHUDAnimationManager createRotateInAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeRotateOut:
            return [DWHUDAnimationManager createRotateOutAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeArcIn:
            return [DWHUDAnimationManager createArcInAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeArcOut:
            return [DWHUDAnimationManager createArcOutAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypeLiftUp:
            return [DWHUDAnimationManager createLiftUpAnimationWithView:view];
            break;
        case DWHUDAnimatoinTypePutDown:
            return [DWHUDAnimationManager createPutDownAnimationWithView:view];
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
    return [view dw_CreateAnimationWithAnimationKey:@"ZoomInAnimation" springingType:DWAnimationSpringTypeScale beginTime:0 fromValue:@(0) toValue:@(1) mass:5 stiffness:500 damping:50 initialVelocity:0];
}

+(DWAnimation *)createZoomOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    return [view dw_CreateAnimationWithAnimationKey:@"ZoomOutAnimation" springingType:DWAnimationSpringTypeScale beginTime:0 fromValue:@(1) toValue:@(0) mass:5 stiffness:500 damping:100 initialVelocity:-13];
}

+(DWAnimation *)createRotateInAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    return [view dw_CreateAnimationWithKey:@"RotateInAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.scaleFrom(0).scaleTo(1).rotateTo(720).duration(0.4).install();
    }];
}

+(DWAnimation *)createRotateOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    return [view dw_CreateAnimationWithKey:@"RotateOutAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.scaleTo(0).rotateTo(1440).duration(0.4).install();
    }];
}

+(DWAnimation *)createArcInAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    
    CGFloat width = view.superview.bounds.size.width;
    CGFloat height = view.superview.bounds.size.height;
    
    CGFloat radius = MAX(width, height) / 2.0;
    
    CGPoint center = CGPointMake(width / 2.0, height / 2.0 - radius);
    
    return [view dw_CreateAnimationWithAnimationKey:@"ArcInAnimation" beginTime:0 duration:1 arcCenter:center radius:radius startAngle:270 endAngle:180 clockwise:NO autoRotate:YES];
}

+(DWAnimation *)createArcOutAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    
    CGFloat width = view.superview.bounds.size.width;
    CGFloat height = view.superview.bounds.size.height;
    
    CGFloat radius = MAX(width, height) / 2.0;
    
    CGPoint center = CGPointMake(width / 2.0, height / 2.0 - radius);
    
    return  [view dw_CreateAnimationWithAnimationKey:@"ArcOutAnimation" beginTime:0 duration:1 arcCenter:center radius:radius startAngle:180 endAngle:90 clockwise:NO autoRotate:YES];
}

+(DWAnimation *)createLiftUpAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    view.layer.position = CGPointMake(view.layer.position.x, view.layer.position.y + view.bounds.size.height / 2.0);
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    return [view dw_CreateAnimationWithKey:@"LiftUpAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateFrom(90).rotateTo(0).axis(X).duration(2).install();
    }];
}


+(DWAnimation *)createPutDownAnimationWithView:(UIView *)view
{
    if (!view.superview) {
        return nil;
    }
    view.layer.position = CGPointMake(view.layer.position.x, view.layer.position.y + view.bounds.size.height / 2.0);
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    return [view dw_CreateAnimationWithKey:@"PutDownAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateFrom(0).rotateTo(90).axis(X).duration(2).install();
    }];
}
@end
