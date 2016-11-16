//
//  DWDefaultAlertLayout.h
//  DWHUD
//
//  Created by Wicky on 16/11/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWDefaultAlertLayout
 
 基本型alert的布局基类
 提供基本型alert的布局公有属性
 
 version 1.0.0
 提供基本型alert的布局公有属性
 */

#import "DWHUDLayout.h"

@interface DWDefaultAlertLayout : DWHUDLayout

///按钮是否横向排列
@property (nonatomic ,assign) BOOL isHorizontal;

///按钮高度
@property (nonatomic ,assign) CGFloat btnHeight;

///按钮分割线颜色
@property (nonatomic ,strong) UIColor * seperatorColor;

@end
