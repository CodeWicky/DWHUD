//
//  DWHUDRingIndicator.m
//  DWHUD
//
//  Created by Wicky on 16/10/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDRingIndicator.h"
#import "DWAnimationHeader.h"
#import "DWHUDComponentMaker.h"
@interface DWHUDRingIndicatorAction : NSObject
+(DWAnimation *)createAnimationWithType:(DWHUDRingIndicatorActionType)type ringLayer:(CALayer *)layer;
@end

@implementation DWHUDRingIndicatorAction

+(DWAnimation *)createAnimationWithType:(DWHUDRingIndicatorActionType)type ringLayer:(CALayer *)layer
{
    switch (type) {
        case DWHUDRingIndicatorActionTypeCycle:
        {
            DWAnimation * endA = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"endA" beginTime:0 duration:2 fromValue:@0 toValue:@1 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * startA = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"startA" beginTime:2 duration:2 fromValue:@0 toValue:@1 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * combineA = [endA combineWithAnimation:startA animationKey:@"ringAction"];
            combineA.repeatCount = MAXFLOAT;
            return combineA;
            break;
        }
        case DWHUDRingIndicatorActionTypeRotateCycle:
        {
            DWAnimation * endA = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"endA" beginTime:0 duration:1.5 fromValue:@0.1 toValue:@0.6 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * startA = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"startA" beginTime:1.5 duration:1.5 fromValue:@0 toValue:@0.5 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * endA2 = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"endA2" beginTime:3 duration:0.5 fromValue:@0.6 toValue:@0.1 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * startA2 = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"startA2" beginTime:3 duration:0.5 fromValue:@0.5 toValue:@0 timingFunctionName:kCAMediaTimingFunctionLinear];
            DWAnimation * combineA = [DWAnimation combineAnimationsInArray:@[endA,startA,endA2,startA2] animationKey:nil];
            combineA.repeatCount = 3;
            DWAnimation * rotateA = [layer dw_CreateAnimationWithKey:@"rotateA" animationCreater:^(DWAnimationMaker *maker) {
                maker.rotateFrom(-90).rotateTo(270).duration(3).install();
                maker.rotateFrom(-90).rotateTo(150).beginTime(3).duration(0.5).install();
                maker.rotateFrom(150).rotateTo(510).beginTime(3.5).duration(3).install();
                maker.rotateFrom(150).rotateTo(390).beginTime(6.5).duration(0.5).install();
                maker.rotateFrom(30).rotateTo(390).beginTime(7).duration(3).install();
                maker.rotateFrom(30).rotateTo(270).beginTime(10).duration(0.5).install();
            }];
            DWAnimation * combineFA = [combineA combineWithAnimation:rotateA animationKey:@"ringAction"];
            combineFA.repeatCount = MAXFLOAT;
            return combineFA;
            break;
        }
        default:
        {
            DWAnimation * rotateA = [layer dw_CreateAnimationWithKey:@"ringAction" animationCreater:^(DWAnimationMaker *maker) {
                maker.rotateFrom(-90).rotateTo(270).duration(2).install();
            }];
            rotateA.repeatCount = MAXFLOAT;
            return rotateA;
            break;
        }
    }
}

@end

@interface DWHUDRingIndicator ()

///指示器
@property (nonatomic ,strong) CAShapeLayer * indicatorLayer;

///环形起始位置
@property (nonatomic ,assign) CGFloat startLocation;

///环形终止位置
@property (nonatomic ,assign) CGFloat endLocation;

///指示器动画
@property (nonatomic ,strong) DWAnimation * animation;

@end

@implementation DWHUDRingIndicator

-(instancetype)initWithFrame:(CGRect)frame needPercentLabel:(BOOL)needPercentLabel
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat radius = MIN(frame.size.width, frame.size.height) / 2.0;
        DWHUDComponentMaker * ringCmp = [DWHUDComponentMaker createRingComponentWithRadius:radius];
        _indicatorLayer = ringCmp.component;
        [self.layer addSublayer:_indicatorLayer];
        _indicatorLayer.position = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
        _animation = ringCmp.animation;
        self.startLocation = 0;
        self.endLocation = 0.9;
        [_animation start];
        if (needPercentLabel) {
            self.textColor = [UIColor blackColor];
            [self drawPercentLabel];
        }
    }
    return self;
}

-(void)updateRingStartLoc:(CGFloat)startLoc endLoc:(CGFloat)endLoc animated:(BOOL)animated
{
    
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    self.startLocation = startLoc;
    self.endLocation = endLoc;
    [CATransaction commit];
}

-(void)drawPercentLabel
{
    self.lbPercent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
    CGFloat fontSize = 15 * self.frame.size.height / 50 - 1;
    self.lbPercent.font = [UIFont systemFontOfSize:fontSize];
    self.lbPercent.textColor = self.textColor;
    self.lbPercent.text = @"100%";
    self.lbPercent.textAlignment = NSTextAlignmentCenter;
    CGSize size = [self.lbPercent sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize indicatorSize = self.frame.size;
    CGPoint origin = CGPointMake(indicatorSize.width / 2 - size.width / 2, indicatorSize.height / 2 - size.height / 2);
    CGRect frame = CGRectZero;
    frame.size = size;
    frame.origin = origin;
    self.lbPercent.frame = frame;
    self.lbPercent.text = @"0%";
    [self addSubview:self.lbPercent];
}

-(void)setTintColor:(UIColor *)tintColor
{
    self.indicatorLayer.strokeColor = tintColor.CGColor;
}

-(UIColor *)tintColor
{
    return [UIColor colorWithCGColor:self.indicatorLayer.strokeColor];
}

-(void)setStartLocation:(CGFloat)startLocation
{
    CGFloat safeNum = [self safeNumber:startLocation];
    _startLocation = safeNum;
    self.indicatorLayer.strokeStart = safeNum;
}

-(void)setEndLocation:(CGFloat)endLocation
{
    CGFloat safeNum = [self safeNumber:endLocation];
    _endLocation = safeNum;
    self.indicatorLayer.strokeEnd = safeNum;
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.lbPercent.textColor = textColor;
}

-(void)setProgress:(CGFloat)progress
{
    CGFloat safeNum = [self safeNumber:progress];
    _progress = safeNum;
    self.lbPercent.text = [NSString stringWithFormat:@"%d%%",100 * (int)safeNum];
}

-(void)setActionType:(DWHUDRingIndicatorActionType)actionType
{
    _actionType = actionType;
    if (_actionType == DWHUDRingIndicatorActionTypePercent) {
        return;
    }
    self.animation = [DWHUDRingIndicatorAction createAnimationWithType:actionType ringLayer:self.indicatorLayer];
    switch (actionType) {
        case DWHUDRingIndicatorActionTypeCycle:
        {
            self.startLocation = 0;
            self.endLocation = 0;
            break;
        }
        case DWHUDRingIndicatorActionTypeRotateCycle:
        {
            self.startLocation = 0;
            self.endLocation = 0.1;
        }
        default:
        {
            self.startLocation = 0;
            self.endLocation = 0.9;
            break;
        }
    }
    [self.animation start];
}
-(CGFloat)safeNumber:(CGFloat)number
{
    if (number > 1) {
        return 1;
    }
    if (number < 0) {
        return 0;
    }
    return number;
}
@end
