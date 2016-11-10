//
//  DWHUDTickIndicator.m
//  DWHUD
//
//  Created by Wicky on 16/10/13.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDTickIndicator.h"
#import "DWAnimation.h"
#import "DWHUDComponentMaker.h"
@interface DWHUDTickIndicator ()

@property (nonatomic ,strong) CAShapeLayer * indicatorLayer;

@property (nonatomic ,strong) DWAnimation * animation;

@end

@implementation DWHUDTickIndicator

-(instancetype)initWithFrame:(CGRect)frame animated:(BOOL)animated
{
    self = [super initWithFrame:frame];
    if (self) {
        DWHUDComponentMaker * tickCmp = [DWHUDComponentMaker createTickComponentWithFrame:frame];
        _indicatorLayer = tickCmp.component;
        [self.layer addSublayer:_indicatorLayer];
        _indicatorLayer.position = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
        if (animated) {
            _animation = tickCmp.animation;
        }
    }
    return self;
}

-(void)startAnimation
{
    if (self.animation) {
         [self.animation start];
    }
}

-(void)setTintColor:(UIColor *)tintColor
{
    self.indicatorLayer.strokeColor = tintColor.CGColor;
    
}

-(UIColor *)tintColor
{
    return [UIColor colorWithCGColor:self.indicatorLayer.strokeColor];
}
@end
