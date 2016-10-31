//
//  DWMessageHUD.m
//  DWHUD
//
//  Created by Wicky on 16/10/31.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWMessageHUD.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDLayout.h"
#import "UIColor+DWColorUtils.h"
#import "DWHUDConstant.h"
@interface DWHUDToastLayout : DWHUDLayout

@end

@implementation DWHUDToastLayout

-(void)layoutDWHUDComponents
{
    DWMessageHUD * hud = self.canvas;
    
    CGPoint center = CGPointMake(hud.frame.size.width / 2.0, hud.frame.size.height / 2.0);
    [hud addSubview:hud.textLabel];
    hud.textLabel.center = center;
}

@end

@implementation DWMessageHUD

+(instancetype)showMessage:(NSString *)msg font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines toView:(UIView *)view limitSize:(CGSize)limitSize autoResize:(BOOL)autoResize hideDelay:(CGFloat)hideDelay
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createLabelComponentWithString:msg font:font numberOfLines:numberOfLines autoresize:autoResize limitSize:limitSize];
    CGSize size = ((UILabel *)maker.component).frame.size;
    CGFloat margin = 5;
    CGSize sizeWithMargin = CGSizeMake(size.width + margin * 2, size.height + margin * 2);
    CGRect frame = CGRectZero;
    frame.size = sizeWithMargin;
    DWHUDToastLayout * layout = [[DWHUDToastLayout alloc] init];
    DWMessageHUD * hud = [[DWMessageHUD alloc] initWithFrame:frame layout:layout];
    hud.textLabel = maker.component;
    hud.textLabel.textColor = [UIColor whiteColor];
    hud.interceptOutsideUserInteraction = YES;
    hud.removeOnHide = YES;
    CGPoint center = CGPointMake(view.frame.size.width / 2.0, view.frame.size.height / 2.0);
    [view addSubview:hud];
    hud.center = center;
    
    if (hideDelay > 0) {
        [NSTimer scheduledTimerWithTimeInterval:hideDelay repeats:NO block:^(NSTimer * _Nonnull timer) {
            [hud hide];
        }];
    }
    
    [hud show];
    hud.backgroundColor = [UIColor blackColor].alphaWith(0.7);
    hud.layer.cornerRadius = 5;
    hud.clipsToBounds = YES;
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
    return [DWMessageHUD showMessage:msg toView:APPWindow.rootViewController.view hideDelay:hideDelay];
}

+(instancetype)showMessage:(NSString *)msg
{
    return [DWMessageHUD showMessage:msg hideDelay:2];
}
@end
