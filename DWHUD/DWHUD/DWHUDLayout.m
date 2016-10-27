//
//  DWHUDLayout.m
//  DWHUD
//
//  Created by Wicky on 16/10/12.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDLayout.h"

@implementation DWHUDLayout

-(void)layoutDWHUDComponents
{
    NSLog(@"you should override this method to place your components");
}

-(void)willShowTheHUD
{
    NSLog(@"you can do something in this method before the hud show");
}

-(void)didHideTheHUD
{
    NSLog(@"you can do something in this method after the hud has been hidden");
}
@end
