//
//  DWPictureHUD.h
//  DWHUD
//
//  Created by Wicky on 2016/11/8.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWPictureHUD
 
 标准图片HUD
 提供标准图片HUDapi
 
 version 1.0.0
 提供标准图片HUDapi
 */

#import "DWHUDCanvas.h"

@interface DWPictureHUD : DWHUDCanvas

/**
 显示图片的imageView
 */
@property (nonatomic ,strong) UIImageView * gifView;

/**
 显示提示的标签
 */
@property (nonatomic ,strong) UILabel * textLabel;

/**
 提示标签距离imageView的偏移量
 */
@property (nonatomic ,assign) CGFloat textLabelOffset;

/**
 生成带有提示的图片HUD并自动展示
 */
+(instancetype)showPicture:(NSString *)picturePath
                   message:(NSString *)msg;

/**
 生成可设置大小的图片HUD并自动展示
 */
+(instancetype)showPicture:(NSString *)picturePath
                   picSize:(CGSize)picSize;

/**
 生成可设置图片、大小、信息、view、隐藏的实例并自动展示
 */
+(instancetype)showPicture:(NSString *)picturePath
                   picSize:(CGSize)picSize
                   message:(NSString *)msg
                    toView:(UIView *)view
         hideOnTouchInside:(BOOL)hideOnTouchInside;

/**
 生成可设置图片、大小、信息、view、隐藏的实例并不自动展示
 */
-(instancetype)initWithPicture:(NSString *)picturePath
                       picSize:(CGSize)picSize
                       message:(NSString *)msg
                        toView:(UIView *)view
             hideOnTouchInside:(BOOL)hideOnTouchInside;
@end
