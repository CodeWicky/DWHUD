//
//  DWHUDWormIndicator.m
//  DWHUD
//
//  Created by Wicky on 16/10/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDWormIndicator.h"
#import "DWAnimationHeader.h"
@interface DWHUDWormIndicator ()

@property (nonatomic ,strong) NSMutableArray * layerArr;

@property (nonatomic ,strong) NSArray * colorArr;

@property (nonatomic ,strong) NSMutableArray * animationsArr;

@end

@implementation DWHUDWormIndicator

-(instancetype)initWithFrame:(CGRect)frame arrOfColors:(NSArray *)colors
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat radius = MIN(frame.size.height, frame.size.width) / 2.0 * 0.8;
        _colorArr = colors.copy;
        [self drawWormLayerWithRadius:radius colors:_colorArr];
        [self createAnimationsWithCount:colors.count radius:radius];
        [self start];
    }
    return self;
}

-(void)start
{
    for (DWAnimation * ani in self.animationsArr) {
        [ani start];
    }
}

-(void)drawWormLayerWithRadius:(CGFloat)radius
                        colors:(NSArray *)colors
{
    for (int i = 0; i < colors.count; i ++) {
        UIColor * color = colors[i];
        CAShapeLayer * layer = [self createLayerWithColor:color radius:radius];
        [self.layerArr addObject:layer];
    }
}

-(void)createAnimationsWithCount:(NSInteger)count
                          radius:(CGFloat)radius
{
    CGFloat step = 0.5 / count;
    for (int i = 0; i < count; i ++) {
        CAShapeLayer * layer = self.layerArr[i];
        [self.animationsArr addObject:[self createAnimationWithLayer:layer offset:(i * step) duration:3 radius:radius]];
    }
}

-(CGPathRef)createPathWithRadius:(CGFloat)radius
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, radius)];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:-M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 3, radius) radius:radius startAngle:-M_PI endAngle:0 clockwise:YES];
    return path.CGPath;
}

-(CAShapeLayer *)createLayerWithColor:(UIColor *)color
                               radius:(CGFloat)radius
{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.bounds = CGRectMake(0, 0, radius * 4, radius);
    layer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self.layer addSublayer:layer];
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeEnd = 0;
    layer.lineWidth = 0.4 * radius;
    layer.lineCap = @"round";
    layer.lineJoin = @"round";
    layer.path = [self createPathWithRadius:radius];
    return layer;
}

-(DWAnimation *)createAnimationWithLayer:(CALayer *)layer
                                  offset:(CGFloat)offset
                                duration:(CGFloat)duration
                                  radius:(CGFloat)radius
{
    if (offset > 0.5) {
        return nil;
    }
    CGFloat time = duration / 4;
    DWAnimation * animation1 = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"animation1" beginTime:0 duration:time fromValue:nil toValue:@(0.5 - offset) timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation2 = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"animation2" beginTime:time duration:time fromValue:nil toValue:@0.5 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation3 = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"animation3" beginTime:(time * 2) duration:time fromValue:nil toValue:@1 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation4 = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"animation4" beginTime:(time * 3) duration:time fromValue:nil toValue:@1 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    CGFloat centerX = self.bounds.size.width / 2.0;
    CGFloat centerY = self.bounds.size.height / 2.0;
    DWAnimation * animation5 = [layer dw_CreateAnimationWithKeyPath:@"position" animationKey:@"animation5" beginTime:0 duration:time fromValue:[NSValue valueWithCGPoint:CGPointMake(centerX + 2 * radius, centerY)] toValue:[NSValue valueWithCGPoint:CGPointMake(centerX + radius, centerY)] timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation6 = [layer dw_CreateAnimationWithKeyPath:@"position" animationKey:@"animation6" beginTime:time duration:time fromValue:nil toValue:[NSValue valueWithCGPoint:CGPointMake(centerX, centerY)] timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation7 = [layer dw_CreateAnimationWithKeyPath:@"position" animationKey:@"animation7" beginTime:(time * 2) duration:time fromValue:nil toValue:[NSValue valueWithCGPoint:CGPointMake(centerX - radius, centerY)] timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    DWAnimation * animation8 = [layer dw_CreateAnimationWithKeyPath:@"position" animationKey:@"animation8" beginTime:(time * 3) duration:time fromValue:nil toValue:[NSValue valueWithCGPoint:CGPointMake(centerX - 2 * radius, centerY)] timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    NSMutableArray * arr = @[animation1,animation2,animation3,animation4,animation5,animation6,animation7,animation8].mutableCopy;
    if (offset) {
        DWAnimation * animation21 = [layer dw_CreateAnimationWithKeyPath:@"strokeEnd" animationKey:@"animation21" beginTime:time duration:time fromValue:nil toValue:@0.5 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
        DWAnimation * animation31 = [layer dw_CreateAnimationWithKeyPath:@"strokeStart" animationKey:@"animation31" beginTime:(time * 2) duration:time fromValue:nil toValue:@(0.5 + offset) timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
        [arr insertObject:animation21 atIndex:2];
        [arr insertObject:animation31 atIndex:4];
    }
    DWAnimation * animations = [DWAnimation combineAnimationsInArray:arr animationKey:@"wormAnimation"];
    animations.repeatCount = MAXFLOAT;
    return animations;
}

-(NSMutableArray *)layerArr
{
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    return _layerArr;
}

-(NSMutableArray *)animationsArr
{
    if (!_animationsArr) {
        _animationsArr = [NSMutableArray array];
    }
    return _animationsArr;
}
@end
