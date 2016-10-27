//
//  DWHUDCanvas.m
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@implementation DWHUDCanvas

-(instancetype)initWithFrame:(CGRect)frame layout:(DWHUDLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layout = layout;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.layout) {
        [self.layout layoutDWHUDComponents];
    }
    else
    {
        NSException *ex = [NSException exceptionWithName: @"Property Error!" reason: @"The property 'layout' can't be nil." userInfo: nil];
        @throw ex;
    }
}

-(void)show
{
    [self.layout willShowTheHUD];
///TODO:
//    添加展示语句
}

-(void)hide
{
///TODO:
//    添加隐藏语句
    [self.layout didHideTheHUD];
}

-(void)setLayout:(DWHUDLayout *)layout
{
    _layout = layout;
    layout.canvas = self;
}
@end
