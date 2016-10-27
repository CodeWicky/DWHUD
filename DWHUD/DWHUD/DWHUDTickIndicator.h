//
//  DWHUDTickIndicator.h
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWHUDTickIndicator : UIView
/**
 初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame
                    animated:(BOOL)animated;
-(void)startAnimation;
@end
