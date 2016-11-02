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

+(instancetype)showErrorWithMessage:(NSString *)msg;

+(instancetype)showErrorWithMessage:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside;

@end
