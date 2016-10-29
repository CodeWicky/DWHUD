//
//  DWHUDComponentMaker.h
//  DWHUD
//
//  Created by Wicky on 16/10/19.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWHUDComponentMaker
 
 生成DWHUD的组件的工厂类
 通过快速生成部分组件后布置在DWHUDCanvas实现自定义HUD
 */

#import <UIKit/UIKit.h>
@class DWAnimation;
@interface DWHUDComponentMaker : NSObject

@property (nonatomic ,strong) DWAnimation * animation;

@property (nonatomic ,strong) id component;

/**
 生成环状组件
 */
+(instancetype)createRingComponentWithRadius:(CGFloat)radius;

/**
 生成对号组件
 */
+(instancetype)createTickComponentWithFrame:(CGRect)frame;

/**
 生成错号组件
 */
+(instancetype)createCrossComponentWithFrame:(CGRect)frame;

/**
 生成叹号组件
 */
+(instancetype)createExclamationComponentWithFrame:(CGRect)frame;

/**
 生成label组件
 
 string:        label显示的文本
 font:          label字体
 numberOfLines  行数
 autoresize     是否自动修正尺寸
 limitSize      限制尺寸
 */
+(instancetype)createLabelComponentWithString:(NSString *)string font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines autoresize:(BOOL)autoresize limitSize:(CGSize)limitSize;

/**
 生成图片组件
 */
+(instancetype)createImageViewWithFrame:(CGRect)frame;
@end
