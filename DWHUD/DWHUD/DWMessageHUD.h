//
//  DWMessageHUD.h
//  DWHUD
//
//  Created by Wicky on 16/10/31.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWMessageHUD
 
 标准toast类
 提供标准TOASTapi
 
 version 1.0.0
 提供标准TOASTapi
 */

#import "DWHUDCanvas.h"

@interface DWMessageHUD : DWHUDCanvas

/**
 toast标签
 */
@property (nonatomic ,strong) UILabel * textLabel;

/**
 toast距父视图Y中中心的偏移量
 */
@property (nonatomic ,assign) CGFloat verticalOffset;

/**
 自动展示toast并于两秒后自动隐藏
 */
+(instancetype)showMessage:(NSString *)msg;

/**
 自动展示toast并设置隐藏延迟
 */
+(instancetype)showMessage:(NSString *)msg
                 hideDelay:(CGFloat)hideDelay;

/**
 自动展示toast至view并设置隐藏延迟
 */
+(instancetype)showMessage:(NSString *)msg
                    toView:(UIView *)view
                 hideDelay:(CGFloat)hideDelay;

/**
 根据font大小展示toast并设置隐藏延迟
 */
+(instancetype)showMessage:(NSString *)msg
                      font:(UIFont *)font
                    toView:(UIView *)view
                 hideDelay:(CGFloat)hideDelay;

/**
 根据字体大小，限制尺寸，是否自动调整尺寸展示自动换行的toast并设置隐藏延迟
 
 limitSize      toast的最大尺寸
 autoResize     是否自动调整尺寸至4:3
 */
+(instancetype)showMessage:(NSString *)msg
                      font:(UIFont *)font
                    toView:(UIView *)view
                 limitSize:(CGSize)limitSize
                autoResize:(BOOL)autoResize
                 hideDelay:(CGFloat)hideDelay;

/**
 根据字体大小、行数、限制尺寸、自动调整展示toast，并设置隐藏延迟
 */
+(instancetype)showMessage:(NSString *)msg
                      font:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines
                    toView:(UIView *)view
                 limitSize:(CGSize)limitSize
                autoResize:(BOOL)autoResize
                 hideDelay:(CGFloat)hideDelay;

/**
 根据条件生成toast实例，并不展示
 */
-(instancetype)initWithMessage:(NSString *)msg
                          font:(UIFont *)font
                 numberOfLines:(NSInteger)numberOfLines
                        toView:(UIView *)view
                     limitSize:(CGSize)limitSize
                    autoResize:(BOOL)autoResize
                     hideDelay:(CGFloat)hideDelay;
@end
