//
//  DWDefaultAlert.m
//  DWHUD
//
//  Created by Wicky on 16/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWDefaultAlert.h"
#import "DWDefaultAlertLayout.h"
#import "DWHUDComponentMaker.h"
#import "UIColor+DWColorUtils.h"
#import "UIImageView+DWGifTool.h"
#import "DWHUDConstant.h"


@interface DWDefaultForAlertLayout : DWDefaultAlertLayout

@property (nonatomic ,assign) CGFloat margin;

@end

@implementation DWDefaultForAlertLayout

-(void)layoutDWHUDComponents
{
    [super layoutDWHUDComponents];
    
    DWDefaultAlert * alert = self.canvas;
    CGFloat delta = self.margin;
    if (alert.iconImageView) {
        alert.iconImageView.center = CGPointMake(alert.bounds.size.width / 2.0, self.margin + alert.iconImageView.bounds.size.height / 2.0);
        delta = alert.iconImageView.bounds.size.height + self.margin * 2;
    }
    else if (alert.titleLabel)
    {
        alert.titleLabel.center = CGPointMake(alert.bounds.size.width / 2.0, self.margin + alert.titleLabel.bounds.size.height / 2.0);
        delta = alert.titleLabel.bounds.size.height + self.margin * 2;
    }
    if (alert.subTitleLabel) {
        CGRect frame = alert.subTitleLabel.frame;
        CGPoint origin = CGPointMake(alert.bounds.size.width / 2.0 - alert.subTitleLabel.bounds.size.width / 2.0, delta);
        frame.origin = origin;
        alert.subTitleLabel.frame = frame;
    }
}

@end

@interface DWDefaultAlert ()

@property (nonatomic ,strong) NSMutableArray * btnKeysArray;

@property (nonatomic ,copy) BtnBlock rightBtnBlock;

@end

@implementation DWDefaultAlert


-(void)addButton:(UIButton *)btn withKey:(NSString *)key
{
    [super addButton:btn withKey:key];
    [self.btnKeysArray addObject:key];
}

-(void)removeBtnForKey:(NSString *)key
{
    [super removeBtnForKey:key];
    [self.btnKeysArray removeObject:key];
}

-(NSMutableArray *)btnKeysArray
{
    if (!_btnKeysArray) {
        _btnKeysArray = [NSMutableArray array];
    }
    return _btnKeysArray;
}

-(instancetype)initWithFrame:(CGRect)frame iconImagePath:(NSString *)imagePath iconSize:(CGSize)size defaultBtnTitle:(NSString *)defaultBtnTitle title:(NSString *)title titleFont:(UIFont *)titleFont subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont toView:(UIView *)view btnHeight:(CGFloat)btnHeight separatorColor:(UIColor *)separatorColor margin:(CGFloat)margin
{
    DWDefaultForAlertLayout * layout = [[DWDefaultForAlertLayout alloc] init];
    layout.isHorizontal = YES;
    layout.btnHeight = btnHeight;
    layout.separatorColor = separatorColor;
    layout.margin = margin;
    self = [super initWithFrame:frame layout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor].alphaWith(0.7);
        self.layer.cornerRadius = 10;
        self.interceptOutsideUserInteraction = YES;
        self.removeOnHide = YES;
        [view addSubview:self];
        CGFloat delta = margin;
        if (imagePath.length) {
            if ([imagePath hasSuffix:@"gif"]) {
                self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) gifPathString:imagePath repeatCount:MAXFLOAT];
            }
            else
            {
                self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSURL * url = nil;
                    if ([imagePath hasPrefix:@"http"]) {
                        url = [NSURL URLWithString:imagePath];
                    }
                    else
                    {
                        url = [NSURL fileURLWithPath:imagePath];
                    }
                    NSData * data = [NSData dataWithContentsOfURL:url];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.iconImageView.image = [UIImage imageWithData:data];
                    });
                });
                self.iconImageView.clipsToBounds = YES;
            }
            [self addSubview:self.iconImageView];
            delta = margin * 2 + size.height;
        }
        else if (title.length)
        {
            UILabel * titleLabel = [DWHUDComponentMaker createLabelComponentWithString:title font:titleFont numberOfLines:1 autoresize:NO limitSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].component;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel = titleLabel;
            [self addSubview:titleLabel];
            delta = margin * 2 + titleLabel.bounds.size.height;
        }
        
        if (subTitle.length) {
            UILabel * subTitleLabel = [DWHUDComponentMaker createLabelComponentWithString:subTitle font:subTitleFont numberOfLines:0 autoresize:NO limitSize:CGSizeMake(self.bounds.size.width - margin * 2, self.bounds.size.height - delta - margin - btnHeight)].component;
            subTitleLabel.textColor = [UIColor blackColor];
            subTitleLabel.clipsToBounds = YES;
            self.subTitleLabel = subTitleLabel;
            
            [self addSubview:subTitleLabel];
        }
        self.center = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0);
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:defaultBtnTitle forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor colorWithRGBString:@"4c99f9"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(defaultBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addButton:btn withKey:@"defaultBtn"];
        self.defaultBtnBlock = ^(DWDefaultAlert * alert){
            [alert hide];
        };
        self.showAnimationType = DWHUDAnimatoinTypeZoomIn;
        self.hideAnimationType = DWHUDAnimatoinTypeZoomOut;
    }
    return self;
}

-(instancetype)initNormalAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle toView:(UIView *)view
{
    CGFloat margin = 15;
    CGFloat btnHeight = 30;
    UIFont * titleFont = [UIFont systemFontOfSize:20];
    UIFont * subTitleFont = [UIFont systemFontOfSize:17];
    if (!view) {
        view = APPRootView;
    }
    CGRect frame = [DWDefaultAlert calculateFrameWithTitle:title titleFont:titleFont subTitle:subTitle subTitleFont:subTitleFont margin:margin btnHeight:btnHeight];
    return [self initWithFrame:frame iconImagePath:nil iconSize:CGSizeZero defaultBtnTitle:defaultBtnTitle title:title titleFont:titleFont subTitle:subTitle subTitleFont:subTitleFont toView:view btnHeight:btnHeight separatorColor:[UIColor colorWithRGBString:@"bbcfd7"] margin:margin];
}

-(instancetype)initNormalAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle toView:(UIView *)view
{
    CGFloat margin = 15;
    CGFloat btnHeight = 30;
    UIFont * subTitleFont = [UIFont systemFontOfSize:17];
    if (!view) {
        view = APPRootView;
    }
    CGRect frame = [DWDefaultAlert calculateFrameWithIconSize:size subTitle:subTitle subTitleFont:subTitleFont margin:margin btnHeight:btnHeight];
    return [self initWithFrame:frame iconImagePath:imagePath iconSize:size defaultBtnTitle:defaultBtnTitle title:nil titleFont:nil subTitle:subTitle subTitleFont:subTitleFont toView:view btnHeight:btnHeight separatorColor:[UIColor colorWithRGBString:@"bbcfd7"] margin:margin];
}

+(instancetype)showAlertWithTitle:(NSString *)title titleFont:(UIFont *)titleFont subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont toView:(UIView *)view separatorColor:(UIColor *)separatorColor defaultBtnTitle:(NSString *)defaultBtnTitle defaultBtnAction:(void(^)(DWDefaultAlert *))defaultBtnAction
{
    if (!view) {
        view = APPRootView;
    }
    CGFloat margin = 15;
    CGFloat btnHeight = 30;
    CGRect frame = [DWDefaultAlert calculateFrameWithTitle:title titleFont:titleFont subTitle:subTitle subTitleFont:subTitleFont margin:margin btnHeight:btnHeight];
    DWDefaultAlert * alert = [[DWDefaultAlert alloc] initWithFrame:frame iconImagePath:nil iconSize:CGSizeZero defaultBtnTitle:defaultBtnTitle title:title titleFont:titleFont subTitle:subTitle subTitleFont:subTitleFont toView:view btnHeight:btnHeight separatorColor:separatorColor margin:margin];
    if (defaultBtnAction) {
        alert.defaultBtnBlock = defaultBtnAction;
    }
    [alert show];
    return alert;
}

+(instancetype)showAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle separatorColor:(UIColor *)separatorColor
{
    return [DWDefaultAlert showAlertWithTitle:title titleFont:[UIFont systemFontOfSize:20] subTitle:subTitle subTitleFont:[UIFont systemFontOfSize:17] toView:nil separatorColor:separatorColor defaultBtnTitle:defaultBtnTitle defaultBtnAction:nil];
}

+(instancetype)showAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle separatorColor:(UIColor *)separatorColor
{
    return [DWDefaultAlert showAlertWithTitle:nil titleFont:nil subTitle:subTitle subTitleFont:[UIFont systemFontOfSize:17] toView:nil separatorColor:separatorColor defaultBtnTitle:defaultBtnTitle defaultBtnAction:nil];
}

+(instancetype)showAlertWithDescription:(NSString *)description
{
    return [DWDefaultAlert showAlertWithTitle:nil subTitle:description defaultBtnTitle:@"我知道了" separatorColor:[UIColor colorWithRGBString:@"bbcfd7"]];
}

+(instancetype)showAlertWithTitle:(NSString *)title subTilte:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock
{
    DWDefaultAlert * alert = [[DWDefaultAlert alloc] initWithTitle:title subTilte:subTitle leftBtnTitle:leftBtnTitle leftBtnBlock:leftBtnBlock rightBtnTitle:rightBtnTitle rightBtnBlock:rightBtnBlock];
    [alert show];
    return alert;
}

+(instancetype)showAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)riginBtnTitle rigthBtnBlock:(BtnBlock)rigthBtnBlock
{
    DWDefaultAlert * alert = [[DWDefaultAlert alloc] initWithIconImagePath:imagePath iconSize:size subTitle:subTitle leftBtnTitle:leftBtnTitle leftBtnBlock:leftBtnBlock rightBtnTitle:riginBtnTitle rightBtnBlock:rigthBtnBlock];
    [alert show];
    return alert;
}

-(instancetype)initWithTitle:(NSString *)title subTilte:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock
{
    self = [self initNormalAlertWithTitle:title subTitle:subTitle defaultBtnTitle:leftBtnTitle toView:nil];
    if (self) {
        [self handleTwoBtnWithLeftBtnBlock:leftBtnBlock rigthBtnTitle:rightBtnTitle rightBtnBlock:rightBtnBlock];
    }
    return self;
}

-(instancetype)initWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock
{
    self = [self initNormalAlertWithIconImagePath:imagePath iconSize:size subTitle:subTitle defaultBtnTitle:leftBtnTitle toView:nil];
    if (self) {
        [self handleTwoBtnWithLeftBtnBlock:leftBtnBlock rigthBtnTitle:rightBtnTitle rightBtnBlock:rightBtnBlock];
    }
    return self;
}

-(void)handleTwoBtnWithLeftBtnBlock:(BtnBlock)leftBtnBlock rigthBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock
{
    [self changeDefaultBtnKeyToLeftBtnKey];
    self.defaultBtnBlock = leftBtnBlock;
    self.rightBtnBlock = rightBtnBlock;
    [self addRightBtnWithTitle:rightBtnTitle];
}

-(void)changeDefaultBtnKeyToLeftBtnKey
{
    UIButton * leftBtn = [self buttonForKey:@"defaultBtn"];
    [self removeBtnForKey:@"defaultBtn"];
    [self addButton:leftBtn withKey:@"leftBtn"];
}

-(void)addRightBtnWithTitle:(NSString *)rightBtnTitle
{
    UIButton * rightBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:rightBtnTitle forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:[UIColor colorWithRGBString:@"4c99f9"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addButton:rightBtn withKey:@"rightBtn"];
}

+(CGRect)calculateFrameWithTitle:(NSString *)title titleFont:(UIFont *)titleFont subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont margin:(CGFloat)margin btnHeight:(CGFloat)btnHeight
{
    DWHUDComponentMaker * compLabel;
    CGSize sizeTitle = CGSizeMake(0, -margin);
    if (title) {
        compLabel = [DWHUDComponentMaker createLabelComponentWithString:title font:titleFont numberOfLines:1 autoresize:NO limitSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        sizeTitle = ((UILabel *)compLabel.component).bounds.size;
    }
    compLabel = [DWHUDComponentMaker createLabelComponentWithString:subTitle font:subTitleFont numberOfLines:0 autoresize:YES limitSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.75, MAXFLOAT)];
    CGSize sizeSubTitle = ((UILabel *)compLabel.component).bounds.size;
    
    return CGRectMake(0, 0, sizeSubTitle.width + margin * 2, sizeTitle.height + sizeSubTitle.height + margin * 3 + btnHeight);
}

+(CGRect)calculateFrameWithIconSize:(CGSize)size subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont margin:(CGFloat)margin btnHeight:(CGFloat)btnHeight
{
    DWHUDComponentMaker * maker = [DWHUDComponentMaker createLabelComponentWithString:subTitle font:subTitleFont numberOfLines:0 autoresize:YES limitSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.75, MAXFLOAT)];
    CGSize sizeSubTitle = ((UILabel *)maker.component).bounds.size;
    return CGRectMake(0, 0, sizeSubTitle.width + margin * 2, size.height + sizeSubTitle.height + margin * 3 + btnHeight);
}

-(void)defaultBtnAction
{
    if (self.defaultBtnBlock) {
        self.defaultBtnBlock(self);
    }
}

-(void)rightBtnAction
{
    if (self.rightBtnBlock) {
        self.rightBtnBlock(self);
    }
}

@end
