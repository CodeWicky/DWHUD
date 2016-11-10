//
//  DWDefaultAlertLayout.h
//  DWHUD
//
//  Created by Wicky on 16/11/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDLayout.h"

@interface DWDefaultAlertLayout : DWHUDLayout

@property (nonatomic ,assign) BOOL isHorizontal;

@property (nonatomic ,assign) CGFloat btnHeight;

@property (nonatomic ,strong) UIColor * seperatorColor;

@end
