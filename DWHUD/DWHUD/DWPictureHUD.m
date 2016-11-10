//
//  DWPictureHUD.m
//  DWHUD
//
//  Created by Wicky on 2016/11/8.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWPictureHUD.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDLayout.h"
#import "UIImageView+DWGifTool.h"
#import "DWHUDConstant.h"
#define MARGIN 5

@interface DWPictureHUDLayout : DWHUDLayout

@end

@implementation DWPictureHUDLayout

-(void)layoutDWHUDComponents
{
    [super layoutDWHUDComponents];
    DWPictureHUD * hud = self.canvas;
    CGFloat width = hud.gifView.bounds.size.width;
    if (hud.textLabel) {
        hud.frame = CGRectMake(0, 0, hud.bounds.size.width, hud.textLabel.bounds.size.height + hud.gifView.bounds.size.height + MARGIN * 2 + (hud.textLabelOffset?hud.textLabelOffset:MARGIN));
        hud.center = CGPointMake(hud.superview.bounds.size.width / 2.0, hud.superview.bounds.size.height / 2.0);
        hud.gifView.frame = CGRectMake(hud.bounds.size.width / 2.0 - width / 2.0, MARGIN, width, hud.gifView.bounds.size.height);
        CGRect frame = hud.textLabel.frame;
        frame.origin = CGPointMake(hud.bounds.size.width / 2.0 - hud.textLabel.bounds.size.width / 2.0, hud.gifView.bounds.size.height + MARGIN + (hud.textLabelOffset?hud.textLabelOffset:MARGIN));
        hud.textLabel.frame = frame;
        [hud addSubview:hud.textLabel];
    }
    [hud addSubview:hud.gifView];
}

@end

@implementation DWPictureHUD

-(instancetype)initWithPicture:(NSString *)picturePath picSize:(CGSize)picSize message:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWHUDComponentMaker * comp = nil;
    if (msg.length) {
        CGFloat limitLength = [UIScreen mainScreen].bounds.size.width * 0.5;
        comp = [DWHUDComponentMaker createLabelComponentWithString:msg font:[UIFont systemFontOfSize:13] numberOfLines:0 autoresize:YES limitSize:CGSizeMake(limitLength, limitLength)];
    }
    CGRect indicatorFrm = CGRectMake(0, 0, picSize.width, picSize.height);
    if (comp) {
        UILabel * label = comp.component;
        CGSize lbSz = label.bounds.size;
        CGFloat tempWidth = lbSz.width + MARGIN * 2;
        indicatorFrm = CGRectMake(0, 0, tempWidth > (picSize.width + MARGIN * 2) ? tempWidth : (picSize.width + MARGIN * 2), lbSz.height + picSize.height + MARGIN * 3);
    }
    DWPictureHUDLayout * layout = [[DWPictureHUDLayout alloc] init];
    self = [super initBasicHUDWithFrame:indicatorFrm layout:layout view:view];
    if (self) {
        if ([picturePath hasSuffix:@"gif"]) {
            self.gifView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, picSize.width, picSize.height) gifPathString:picturePath repeatCount:MAXFLOAT];
        }
        else
        {
            self.gifView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, picSize.width, picSize.height)];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSURL * url = nil;
                if ([picturePath hasPrefix:@"http"]) {
                    url = [NSURL URLWithString:picturePath];
                }
                else
                {
                    url = [NSURL fileURLWithPath:picturePath];
                }
                NSData * data = [NSData dataWithContentsOfURL:url];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.gifView.image = [UIImage imageWithData:data];
                });
            });
        }
        
        self.gifView.layer.cornerRadius = 5;
        self.gifView.clipsToBounds = YES;
        if (comp) {
            self.textLabel = comp.component;
            self.textLabel.textColor = [UIColor whiteColor];
            self.textLabel.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

+(instancetype)showPicture:(NSString *)picturePath picSize:(CGSize)picSize message:(NSString *)msg toView:(UIView *)view hideOnTouchInside:(BOOL)hideOnTouchInside
{
    DWPictureHUD * hud = [[DWPictureHUD alloc] initWithPicture:picturePath picSize:picSize message:msg toView:view hideOnTouchInside:hideOnTouchInside];
    [hud show];
    return hud;
}

+(instancetype)showPicture:(NSString *)picturePath message:(NSString *)msg
{
    return [DWPictureHUD showPicture:picturePath picSize:CGSizeMake(100, 100) message:msg toView:APPRootView hideOnTouchInside:NO];
}

+(instancetype)showPicture:(NSString *)picturePath picSize:(CGSize)picSize
{
    return [DWPictureHUD showPicture:picturePath picSize:picSize message:nil toView:APPRootView hideOnTouchInside:NO];
}

-(void)setTextLabelOffset:(CGFloat)textLabelOffset
{
    if (self.textLabel) {
        _textLabelOffset = textLabelOffset;
        [self layoutIfNeeded];
    }
}

@end
