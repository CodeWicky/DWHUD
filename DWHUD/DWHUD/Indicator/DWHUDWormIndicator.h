//
//  DWHUDWormIndicator.h
//  DWHUD
//
//  Created by Wicky on 16/10/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 DWHUDWormIndicator
 
 一款趣味指示器
 虫子前进指示器
 
 version 1.0.0
 提供生成虫子前进指示器api
 */

@interface DWHUDWormIndicator : UIView
-(instancetype)initWithFrame:(CGRect)frame
                 arrOfColors:(NSArray *)colors;
@end
