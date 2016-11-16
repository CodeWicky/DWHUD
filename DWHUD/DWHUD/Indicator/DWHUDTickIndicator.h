//
//  DWHUDTickIndicator.h
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 DWHUDTickIndicator
 
 对号指示器
 快速生成对号指示器
 
 version 1.0.0
 提供生成对号指示器api
 */

@interface DWHUDTickIndicator : UIView
/**
 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame
                    animated:(BOOL)animated;
-(void)startAnimation;
@end
