//
//  DWHUDCanvas.h
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWHUDLayout.h"
@interface DWHUDCanvas : UIView
@property (nonatomic ,strong) DWHUDLayout * layout;
@property (nonatomic ,assign) BOOL maskBackView;
-(instancetype)initWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout;
-(void)show;
-(void)hide;
@end
