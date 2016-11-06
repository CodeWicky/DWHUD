//
//  DWIndicatorHUD.h
//  DWHUD
//
//  Created by Wicky on 16/11/2.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@interface DWIndicatorHUD : DWHUDCanvas

/**
 指示器
 */
@property (nonatomic ,strong) CALayer * indicator;

/**
 描述标签
 */
@property (nonatomic ,strong) UILabel * textLabel;

/**
 内部点击时是否隐藏
 */
@property (nonatomic ,assign) BOOL hideOnTouchInside;

/**
 展示完成信息
 */
+(instancetype)showCompleteWithMessage:(NSString *)msg;

+(instancetype)showCompleteWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside;

/**
 展示错误信息
 */
+(instancetype)showErrorWithMessage:(NSString *)msg;

+(instancetype)showErrorWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside;

/**
 展示警告信息
 */
+(instancetype)showExclamationWithMessage:(NSString *)msg;

+(instancetype)showExclamationWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside;

/**
 展示自定义指示器的信息
 */
+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg;

+(instancetype)showIndicator:(CALayer *)indicator withAnimation:(DWAnimation *)animaiton msg:(NSString *)msg  needRing:(BOOL)needRing toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside;
@end
