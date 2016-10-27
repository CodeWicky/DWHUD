//
//  DWHUDComponentMaker.m
//  DWHUD
//
//  Created by Wicky on 16/10/19.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDComponentMaker.h"
#import "UIBezierPath+DWPathUtils.h"
#import "UIImageView+DWGifTool.h"
@implementation DWHUDComponentMaker

+(instancetype)createRingComponentWithRadius:(CGFloat)radius
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [comp createRingLayerWithRadius:radius];
    comp.animation = [comp createRingDefaultAnimationWithLayer:comp.component];
    return comp;
}

-(CAShapeLayer *)createRingLayerWithRadius:(CGFloat)radius
{
    CGRect frame = CGRectMake(0, 0, radius * 2, radius * 2);
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.bounds = frame;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    layer.lineWidth = radius * 0.12;
    
    layer.lineCap = @"round";
    
    CGRect pathFrame = CGRectMake(layer.lineWidth / 2.0, layer.lineWidth / 2.0, radius * 2 - layer.lineWidth, radius * 2 - layer.lineWidth);
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:pathFrame];
    layer.path = path.CGPath;
    
    
    layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1.0);
    
    return layer;
}

-(DWAnimation *)createRingDefaultAnimationWithLayer:(CALayer *)layer
{
    DWAnimation * rotateA = [layer dw_CreateAnimationWithKey:@"rotateA" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateFrom(-90).rotateTo(270).duration(2).install();
    }];
    rotateA.repeatCount = MAXFLOAT;
    rotateA.animationKey = @"ringAction";
    return rotateA;
}

+(instancetype)createTickComponentWithFrame:(CGRect)frame
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [comp createTickLayerWithFrame:frame];
    comp.animation = [comp createTickAnimationWithLayer:comp.component];
    return comp;
}

-(CAShapeLayer *)createTickLayerWithFrame:(CGRect)frame
{
    CGFloat length = MIN(frame.size.width, frame.size.height);
    frame = CGRectMake(0, 0, length, length);
    
    CAShapeLayer * indicator = [CAShapeLayer layer];
    indicator.fillColor = [UIColor clearColor].CGColor;
    indicator.strokeColor = [UIColor blackColor].CGColor;
    indicator.lineWidth = length * 0.06;
    indicator.bounds = frame;
    indicator.lineCap = @"round";
    indicator.lineJoin = @"round";
    
    CGFloat width = length / 6.0;
    
    UIBezierPath * bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(width * 1.5, width * 3)];
    [bezier addLineToPoint:CGPointMake(width * 2.5, width * 4)];
    [bezier addLineToPoint:CGPointMake(width * 4.5, width * 2)];
    
    indicator.path = bezier.CGPath;
    
    return indicator;
}

-(DWAnimation *)createTickAnimationWithLayer:(CAShapeLayer *)layer
{
    return [[DWAnimation alloc] initAnimationWithLayer:layer animationKey:@"tickAnimation" keyPath:@"strokeEnd" beginTime:0 fromValue:@0 toValue:@1 duration:1 timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
}

+(instancetype)createCrossComponentWithFrame:(CGRect)frame
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [comp createCrossLayerWithFrame:frame];
    CALayer * layer = comp.component;
    comp.animation = [comp createCrossAnimationWithMaskLayer:layer.mask];
    return comp;
}

-(CAShapeLayer *)createCrossLayerWithFrame:(CGRect)frame
{
    CGFloat length = MIN(frame.size.width, frame.size.height);
    CGFloat width = length / 6.0;

    UIBezierPath * bezierP = [UIBezierPath bezierPath];
    [bezierP moveToPoint:CGPointMake(0, 0)];
    [bezierP addLineToPoint:CGPointMake(width * 4, width * 4)];
    [bezierP moveToPoint:CGPointMake(0, width * 4)];
    [bezierP addLineToPoint:CGPointMake(width * 4, 0)];
    
    CAShapeLayer * crossLayer = [CAShapeLayer layer];
    crossLayer.bounds = CGRectMake(0, 0, width * 4, width * 4);
    crossLayer.position = CGPointMake(width * 3, width * 3);
    crossLayer.fillColor = [UIColor clearColor].CGColor;
    crossLayer.strokeColor = [UIColor blackColor].CGColor;
    crossLayer.lineWidth = length * 0.06;
    crossLayer.path = bezierP.CGPath;
    crossLayer.lineCap = @"round";
    crossLayer.lineJoin = @"round";
    
    CGRect maskF = CGRectMake(0, 0, 6 * width, 6 * width);
    UIBezierPath * cirP = [UIBezierPath bezierPathWithOvalInRect:maskF];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.bounds = maskF;
    maskLayer.position = CGPointMake(width * 2, width * 2);
    maskLayer.path = cirP.CGPath;
    crossLayer.mask = maskLayer;
    return crossLayer;
}

-(DWAnimation *)createCrossAnimationWithMaskLayer:(CALayer *)maskLayer
{
    return [maskLayer dw_CreateAnimationWithKey:@"maskAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.scaleFrom(0).scaleTo(1).duration(0.75).install();
    }];
}

+(instancetype)createExclamationComponentWithFrame:(CGRect)frame
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [comp createExclamationLayerWithFrame:frame];
    comp.animation = [comp createExclamationAnimationWithLayer:comp.component];
    return comp;
}

-(CALayer *)createExclamationLayerWithFrame:(CGRect)frame
{
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    frame.origin = CGPointZero;
    layer.bounds = frame;
    
    CGFloat width = MIN(frame.size.width, frame.size.height);
    CGFloat length = width / 6;
    
    CAShapeLayer * layer1 = [CAShapeLayer layer];
    layer1.fillColor = [UIColor blackColor].CGColor;
    layer1.bounds = CGRectMake(0, 0, width, width);
    layer1.position = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
    [layer addSublayer:layer1];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithPathMaker:^(DWPathMaker *maker) {
        maker.MoveTo(length * 2.5,length * 1.5).AddArcWithPoint(length * 2.5,length * 1.5,length * 3.5,length * 1.5,length * 0.5,YES,NO).AddLineTo( length * 3.25,length * 4.25).AddArcWithPoint(length * 3.25,length * 4.25,length * 2.75,length * 4.25,length * 0.25,YES,NO).ClosePath();
    }];
    layer1.path = path.CGPath;
    
    CAShapeLayer * layer2 = [CAShapeLayer layer];
    layer2.fillColor = [UIColor blackColor].CGColor;
    layer2.bounds = CGRectMake(0, 0, width, width);
    layer2.position = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
    [layer addSublayer:layer2];
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(length * 2.75, length * 4.75, length * 0.5, length * 0.5)];
    layer2.path = path2.CGPath;
    
    CAShapeLayer * mask = [CAShapeLayer layer];
    mask.lineWidth = length * 3;
    mask.bounds = layer1.bounds;
    mask.position = CGPointMake(width / 2.0, width / 2.0);
    mask.strokeColor = [UIColor blackColor].CGColor;
    UIBezierPath * pathM = [UIBezierPath bezierPathWithPathMaker:^(DWPathMaker *maker) {
        maker.MoveTo(length * 3,length).AddLineTo(length * 3,length * 5.25);
    }];
    mask.path = pathM.CGPath;
    layer.mask = mask;
    
    return layer;
}

-(DWAnimation *)createExclamationAnimationWithLayer:(CALayer *)layer
{
    DWAnimation * animation1 = [layer.mask dw_CreateAnimationWithAnimationKey:@"maskAnimation" keyPath:@"strokeEnd" beginTime:0 fromValue:@0 toValue:@1 duration:1 timingFunctionName:kCAMediaTimingFunctionDefault];
    return animation1;
}

+(instancetype)createLabelComponentWithString:(NSString *)string font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines autoresize:(BOOL)autoresize limitSize:(CGSize)limitSize
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [comp createLabelWithString:string font:font numberOfLines:numberOfLines autoresize:autoresize limitSize:limitSize];
    comp.animation = nil;
    return comp;
}

-(UILabel *)createLabelWithString:(NSString *)string font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines autoresize:(BOOL)autoresize limitSize:(CGSize)limitSize
{
    UILabel * label = [[UILabel alloc] init];
    if (font) {
        label.font = font;
    }
    label.numberOfLines = numberOfLines;
    label.text = string;
    label.textColor = [UIColor blackColor];
    CGSize size = [label sizeThatFits:limitSize];
    if (size.height > limitSize.height) {
        size.height = limitSize.height;
    }
    ///自动规划尺寸（使其在限制尺寸内尽可能保证宽高比1.25）
    if (autoresize) {
        CGFloat limitScale = 1.33;
        CGFloat limitHeight = limitSize.height;
        while (size.width / size.height > limitScale) {
            CGSize tempSize = size;
            limitSize.width = size.width / 1.1;
            size = [label sizeThatFits:limitSize];
            if (size.height > limitHeight || size.width < size.height) {
                size = tempSize;
                break;
            }
        }
    }
    CGRect frame = CGRectZero;
    frame.size = size;
    label.frame = frame;
    return label;
}

+(instancetype)createImageViewWithFrame:(CGRect)frame
{
    DWHUDComponentMaker * comp = [[DWHUDComponentMaker alloc] init];
    comp.component = [[UIImageView alloc] initWithFrame:frame];
    comp.animation = nil;
    return comp;
}

@end
