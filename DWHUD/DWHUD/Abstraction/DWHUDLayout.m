//
//  DWHUDLayout.m
//  DWHUD
//
//  Created by Wicky on 16/10/12.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDLayout.h"
#import "DWHUDConstant.h"
@implementation DWHUDLayout

-(void)layoutDWHUDComponents
{
    DWLog(@"you should override this method to place your components");
    if ([self.canvas isKindOfClass:[UIView class]]) {
        UIView * canvas = self.canvas;
        [canvas.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    else if ([self.canvas isKindOfClass:[CALayer class]])
    {
        CALayer * layer = self.canvas;
        [layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
}

-(void)willShowTheHUD
{
    DWLog(@"you can do something in this method before the hud show");
}

-(void)didHideTheHUD
{
    DWLog(@"you can do something in this method after the hud has been hidden");
}
@end
