//
//  DWHUDCanvas.h
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWHUDLayout.h"
@class DWAnimation;
@interface DWHUDCanvas : UIView
/**
 布局类
 */
@property (nonatomic ,strong) DWHUDLayout * layout;

/**
 是否展示蒙版
 */
@property (nonatomic ,assign) BOOL maskBackView;

/**
 蒙版颜色
 */
@property (nonatomic ,strong) UIColor * maskBackViewColor;

/**
 拦截外部用户响应
 */
@property (nonatomic ,assign) BOOL interceptOutsideUserInteraction;

/**
 点击外部时隐藏
 */
@property (nonatomic ,assign) BOOL hideOnTouchOutside;

/**
 隐藏时移除
 */
@property (nonatomic ,assign) BOOL removeOnHide;

/**
 展示动画
 */
@property (nonatomic ,strong) DWAnimation * showAnimation;

/**
 完成展示回调
 */
@property (nonatomic ,copy) void(^didShowBlock) (DWHUDCanvas *);

/**
 隐藏动画
 */
@property (nonatomic ,strong) DWAnimation * hideAnimation;

/**
 完成隐藏回调
 */
@property (nonatomic ,copy) void (^didHideBlock) (DWHUDCanvas *);

/**
 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout;

/**
 基本画布快速生成
 圆角5、背景色0.7黑、关闭交互、隐藏时移除、添加至view的中心
 */
+(instancetype)createBasicHUDWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout view:(UIView *)view;

/**
 展示方法
 */
-(void)show;

/**
 隐藏方法
 */
-(void)hide;
@end
