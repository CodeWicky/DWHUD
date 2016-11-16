//
//  DWDefaultAlertLayout.h
//  DWHUD
//
//  Created by Wicky on 16/11/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDLayout.h"

@interface DWDefaultAlertLayout : DWHUDLayout

///按钮是否横向排列
@property (nonatomic ,assign) BOOL isHorizontal;

///按钮高度
@property (nonatomic ,assign) CGFloat btnHeight;

///按钮分割线颜色
@property (nonatomic ,strong) UIColor * seperatorColor;

@end
