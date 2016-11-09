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
@end
