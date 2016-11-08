//
//  DWMessageHUD.m
//  DWHUD
//
//  Created by Wicky on 16/10/31.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWMessageHUD.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDConstant.h"
#import "DWAnimationHeader.h"
@interface DWHUDToastLayout : DWHUDLayout

@end

@implementation DWHUDToastLayout

-(void)layoutDWHUDComponents
{
    DWMessageHUD * hud = self.canvas;
    
    CGPoint center = CGPointMake(hud.frame.size.width / 2.0, hud.frame.size.height / 2.0);
    if (hud.verticalOffset) {
        hud.center = CGPointMake(hud.superview.bounds.size.width / 2.0, hud.superview.bounds.size.height / 2.0 + hud.verticalOffset);
    }
    [hud addSubview:hud.textLabel];
    hud.textLabel.center = center;
}

@end

@implementation DWMessageHUD

#pragma mark ---接口方法---

-(instancetype)initWithMessage:(NSString *)msg font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines toView:(UIView *)view limitSize:(CGSize)limitSize autoResize:(BOOL)autoResize hideDelay:(CGFloat)hideDelay
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createLabelComponentWithString:msg font:font numberOfLines:numberOfLines autoresize:autoResize limitSize:limitSize];
    CGSize size = ((UILabel *)maker.component).frame.size;
    CGFloat margin = 5;
    CGSize sizeWithMargin = CGSizeMake(size.width + margin * 2, size.height + margin * 2);
    CGRect frame = CGRectZero;
    frame.size = sizeWithMargin;
    DWHUDToastLayout * layout = [[DWHUDToastLayout alloc] init];
    self = [super initBasicHUDWithFrame:frame layout:layout view:view];
    if (self) {
        self.textLabel = maker.component;
        self.textLabel.textColor = [UIColor whiteColor];
        
        self.showAnimation = CreateShowAnimation(self);
        self.hideAnimation = CreateHideAniamtion(self);
        
        if (hideDelay > 0) {
            [NSTimer scheduledTimerWithTimeInterval:hideDelay repeats:NO block:^(NSTimer * _Nonnull timer) {
                [self hide];
            }];
        }
    }
    return self;
}

+(instancetype)showMessage:(NSString *)msg font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines toView:(UIView *)view limitSize:(CGSize)limitSize autoResize:(BOOL)autoResize hideDelay:(CGFloat)hideDelay
{
    
    DWMessageHUD * hud = [[DWMessageHUD alloc] initWithMessage:msg font:font numberOfLines:numberOfLines toView:view limitSize:limitSize autoResize:autoResize hideDelay:hideDelay];
    [hud show];
    return hud;
}



+(instancetype)showMessage:(NSString *)msg font:(UIFont *)font toView:(UIView *)view limitSize:(CGSize)limitSize autoResize:(BOOL)autoResize hideDelay:(CGFloat)hideDelay
{
    return [DWMessageHUD showMessage:msg font:font numberOfLines:0 toView:view limitSize:limitSize autoResize:autoResize hideDelay:hideDelay];
}

+(instancetype)showMessage:(NSString *)msg font:(UIFont *)font toView:(UIView *)view hideDelay:(CGFloat)hideDelay
{
    return [DWMessageHUD showMessage:msg font:font toView:view limitSize:CGSizeMake(view.bounds.size.width * 0.8, view.bounds.size.width * 0.8) autoResize:YES hideDelay:hideDelay];
}

+(instancetype)showMessage:(NSString *)msg toView:(UIView *)view hideDelay:(CGFloat)hideDelay
{
    return [DWMessageHUD showMessage:msg font:[UIFont systemFontOfSize:13] toView:view hideDelay:hideDelay];
}

+(instancetype)showMessage:(NSString *)msg hideDelay:(CGFloat)hideDelay
{
    return [DWMessageHUD showMessage:msg toView:APPRootView hideDelay:hideDelay];
}

+(instancetype)showMessage:(NSString *)msg
{
    return [DWMessageHUD showMessage:msg hideDelay:2];
}

#pragma mark ---工具方法---

DWAnimation * (^CreateShowAnimation)(DWHUDCanvas *) = ^(DWHUDCanvas * canvas){
    return [canvas dw_CreateAnimationWithKey:@"showAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.scaleFrom(0.7).scaleTo(1).alphaFrom(0.7).alphaTo(1).duration(0.2).install();
    }];
};

DWAnimation * (^CreateHideAniamtion)(DWHUDCanvas *) = ^(DWHUDCanvas * canvas){
    return [canvas dw_CreateAnimationWithKey:@"hideAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.alphaTo(0).duration(0.2).install();
    }];
};

#pragma mark ---setter/getter---
-(void)setVerticalOffset:(CGFloat)verticalOffset
{
    _verticalOffset = verticalOffset;
    [self layoutIfNeeded];
}

@end
