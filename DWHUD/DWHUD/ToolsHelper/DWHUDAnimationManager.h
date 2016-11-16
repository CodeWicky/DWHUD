//
//  DWHUDAnimationManager.h
//  DWHUD
//
//  Created by Wicky on 16/11/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWHUDConstant.h"
/**
 DWHUDAnimationManager
 
 生成DWHUD的动画的工厂类
 快捷生成展示、隐藏动画
 
 version 1.0.0
 定义基本动画快捷生成
 */

@class DWAnimation;
@interface DWHUDAnimationManager : NSObject

+(DWAnimation *)createAnimationWithView:(UIView *)view type:(DWHUDAnimatoinType)type;
+(DWAnimation *)createFallInAnimationWithView:(UIView *)view;
+(DWAnimation *)createFallOutAnimationWithView:(UIView *)view;
+(DWAnimation *)createFlyInAnimationWithView:(UIView *)view;
+(DWAnimation *)createFlyOutAnimationWithView:(UIView *)view;
+(DWAnimation *)createZoomInAnimationWithView:(UIView *)view;
+(DWAnimation *)createZoomOutAnimationWithView:(UIView *)view;
+(DWAnimation *)createRotateInAnimationWithView:(UIView *)view;
+(DWAnimation *)createRotateOutAnimationWithView:(UIView *)view;
+(DWAnimation *)createArcInAnimationWithView:(UIView *)view;
+(DWAnimation *)createArcOutAnimationWithView:(UIView *)view;
+(DWAnimation *)createLiftUpAnimationWithView:(UIView *)view;
+(DWAnimation *)createPutDownAnimationWithView:(UIView *)view;
@end
