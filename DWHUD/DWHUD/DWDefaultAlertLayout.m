//
//  DWDefaultAlertLayout.m
//  DWHUD
//
//  Created by Wicky on 16/11/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWDefaultAlertLayout.h"
#import "DWDefaultAlert.h"
#import "UIColor+DWColorUtils.h"


@implementation DWDefaultAlertLayout

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.isHorizontal = YES;
        self.btnHeight = 30;
        self.separatorColor = [UIColor colorWithRGBString:@"b2b2b2"];
    }
    return self;
}

-(void)layoutDWHUDComponents
{
    [super layoutDWHUDComponents];
    
    DWDefaultAlert * alert = self.canvas;
    NSMutableArray * arr = [alert valueForKey:@"btnKeysArray"];
    CGFloat delta = 0;
    for (NSString * str in arr) {
        UIButton * btn = [alert buttonForKey:str];
        if (self.isHorizontal) {
            btn.frame = CGRectMake(delta, alert.bounds.size.height - self.btnHeight, alert.bounds.size.width * 1.0 / arr.count, self.btnHeight);
        }
        else
        {
            btn.frame = CGRectMake(0, alert.bounds.size.height - self.btnHeight * arr.count + delta, alert.bounds.size.width, self.btnHeight);
        }
        [alert addSubview:btn];
        if (self.isHorizontal) {
            delta += alert.bounds.size.width * 1.0 / arr.count;
        }
        else
        {
            delta += self.btnHeight;
        }
        [self addLineToBtn:btn isHorizontal:self.isHorizontal isLast:[str isEqualToString:arr.lastObject]];
    }
}

-(void)addLineToBtn:(UIButton *)btn
       isHorizontal:(BOOL)isHorizontal
             isLast:(BOOL)isLast
{
    if (isHorizontal) {
        CALayer * HLine = [CALayer layer];
        HLine.backgroundColor = self.separatorColor.CGColor;
        HLine.bounds = CGRectMake(0, 0, btn.frame.size.width, 0.5);
        HLine.position = CGPointMake(btn.frame.size.width / 2.0, 0.25);
        [btn.layer addSublayer:HLine];
        if (!isLast) {
            CALayer * VLine = [CALayer layer];
            VLine.backgroundColor = self.separatorColor.CGColor;
            VLine.bounds = CGRectMake(0, 0, 0.5, btn.frame.size.height);
            VLine.position = CGPointMake(btn.frame.size.width - 0.25, btn.frame.size.height / 2.0);
            [btn.layer addSublayer:VLine];
        }
    }
    else
    {
        CALayer * HLine = [CALayer layer];
        HLine.backgroundColor = self.separatorColor.CGColor;
        HLine.bounds = CGRectMake(0, 0, btn.frame.size.width, 0.5);
        HLine.position = CGPointMake(btn.frame.size.width / 2.0, 0.25);
        [btn.layer addSublayer:HLine];
    }
}

@end
