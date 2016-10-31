//
//  ViewController.m
//  DWHUD
//
//  Created by Wicky on 16/10/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "ViewController.h"
#import "DWHUDRingIndicator.h"
#import "DWHUDWormIndicator.h"
#import "DWHUDTickIndicator.h"
#import "DWHUDComponentMaker.h"
#import "DWHUDCanvas.h"
#import "DWHUDLayout.h"
#import "UIBezierPath+DWPathUtils.h"
#import "DWHUDCanvas.h"
#import "DWAnimationHeader.h"
#import "DWMessageHUD.h"
@interface ViewController ()

@property (nonatomic ,strong) DWHUDTickIndicator * hud;

@property (nonatomic ,strong) NSMutableArray * arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//
//    DWHUDRingIndicator * hud = [[DWHUDRingIndicator alloc] initWithFrame:CGRectMake(100, 100, 200, 200) needPercentLabel:YES];
//    hud.tintColor = [UIColor redColor];
//    hud.textColor = [UIColor redColor];
//    hud.startLocation = 0.25;
//    hud.endLocation = 0.5;
//    [hud updateRingStartLoc:0 endLoc:0 animated:NO];
//    hud.progress = 0.5;
////    hud.actionType = DWHUDRingIndicatorActionTypeDefault;
//    [self.view addSubview:hud];
//    self.hud = hud;
//
////    DWHUDWormIndicator * hud = [[DWHUDWormIndicator alloc] initWithFrame:CGRectMake(100, 100, 50, 50) arrOfColors:@[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor orangeColor]]];
////    hud.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    DWHUDTickIndicator * hud = [[DWHUDTickIndicator alloc] initWithFrame:CGRectMake(100, 100, 150, 150) animated:YES];
//    hud.backgroundColor = [UIColor redColor];
//    self.hud = hud;
//    [self.view addSubview:hud];
////    hud.backgroundColor = [UIColor yellowColor];
////    hud.center = self.view.center;
//    UIButton * bt = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [bt setFrame:CGRectMake(0, 0, 100, 100)];
//    bt.center = self.view.center;
//    bt.backgroundColor = [UIColor redColor];
//    [bt addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:bt];
//
//    DWHUDLayout *layout = [[DWHUDLayout alloc] init];
//    DWHUDCanvas * ca = [[DWHUDCanvas alloc] initWithFrame:CGRectMake(300, 300, 50, 50) layout:layout];
//    
//    [self.view addSubview:ca];
//    
//    UIActivityIndicatorView * ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    ind.frame = CGRectMake(0, 0, 100, 100);
//    ind.center = CGPointMake(self.view.center.x , self.view.center.y - 100);
//    [self.view addSubview:ind];
//    [ind startAnimating];
    
//    NSMutableArray * arr = [NSMutableArray array];
//    self.arr = arr;
//    NSMutableString * string1 = [NSMutableString stringWithString:@"1"];
//    NSMutableString * string2 = [NSMutableString stringWithString:@"1"];
//    [arr addObject:string1];
//    NSLog(@"---%p",[arr lastObject]);
//    [arr addObject:string2];
//    NSLog(@"---%p",[arr lastObject]);
    
    
    
//    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
//    CAShapeLayer * maskL = [CAShapeLayer layer];
//    maskL.path = bezier.CGPath;
//    maskL.position = self.view.center;
//    maskL.bounds = CGRectMake(0, 0, 100, 100);
//    
//    self.view.layer.mask = maskL;
//    
//    [[maskL dw_CreateAnimationWithKey:@"scale" animationCreater:^(DWAnimationMaker *maker) {
//        maker.scaleFrom(0).scaleTo(1).beginTime(2).duration(2).install();
//    }] start];
    
//    DWHUDComponentMaker * comp = [DWHUDComponentMaker createCrossComponentWithFrame:CGRectMake(0, 0, 150, 150)];
//    [self.view.layer addSublayer:comp.layer];
//    comp.layer.position = self.view.center;
//    comp.layer.backgroundColor = [UIColor yellowColor].CGColor;
//    [comp.animation start];
//    UITextField * txt = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    txt.center = self.view.center;
//    txt.placeholder = @"123456";
//    [txt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
//    UILabel * label = [txt valueForKeyPath:@"_placeholderLabel"];
//    label.textColor = [UIColor yellowColor];
//    [self.view addSubview:txt];
//    NSLog(@"---%@",label);
//    DWHUDComponentMaker * maker = [DWHUDComponentMaker createLabelComponentWithString:@"123fdaljs;faksdjfal;ksdfjalsdkfjalskfdj;alsdkfj;afdsafasdfasdfasdfaidfupoaisudfoaisudfpasjdfkasfjda;lskdskdjasdlfasldfalsdkfldsfaskdlasdkfskdjfiomfwemlsdkfjas;lkdjf" font:[UIFont systemFontOfSize:17] numberOfLines:0 autoresize:YES limitSize:CGSizeMake(1000, 200)];
//    UILabel * label = maker.component;
//    [self.view addSubview:label];
//    label.center = self.view.center;
//    CGFloat width = 200;
//    CGFloat length = width / 4;
//    UIBezierPath * path = [UIBezierPath bezierPathWithPathMaker:^(DWPathMaker *maker) {
////        maker.MoveTo(length * 2.5,length * 1.5).AddArcWithPoint(length * 2.5,length * 1.5,length * 3.5,length * 1.5,length * 0.5,YES).AddLineTo( length * 3.25,length * 4.25).AddArcWithPoint(length * 3.25,length * 4.25,length * 2.75,length * 4.25,length * 0.25,YES).ClosePath();
//        maker.MoveTo(length * 1,length * 2).AddArcWithPoint(length * 1,length * 2,length * 2,length * 3,length,NO,NO);
//    }];
//    
//    CAShapeLayer * layer = [CAShapeLayer layer];
//    layer.backgroundColor = [UIColor yellowColor].CGColor;
//    layer.fillColor = [UIColor redColor].CGColor;
//    layer.bounds = CGRectMake(0, 0, width, width);
//    [self.view.layer addSublayer:layer];
//    layer.position = self.view.center;
//    layer.path = path.CGPath;
//    DWHUDComponentMaker * maker = [DWHUDComponentMaker createExclamationComponentWithFrame:CGRectMake(0, 0, 200, 200)];
//    CALayer * layer = maker.component;
//    layer.position = self.view.center;
//    [self.view.layer addSublayer:layer];
//    [maker.animation start];
//    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [btn setFrame:CGRectMake(0, 0, 100, 30)];
//    btn.center = self.view.center;
//    [self.view addSubview:btn];
//    [btn setBackgroundColor:[UIColor greenColor]];
//    [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
//    DWHUDCanvas * cav = [DWHUDCanvas new];
//    cav.layout = [DWHUDLayout new];
//    cav.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview:cav];
//    cav.backgroundColor = [UIColor yellowColor];
//    cav.interceptOutsideUserInteraction = YES;
//    cav.maskBackView = YES;
//    cav.maskBackViewColor = [UIColor redColor];
//    cav.hideOnTouchOutside = YES;
//    cav.removeOnHide = YES;
//    cav.showAnimation = [cav dw_CreateAnimationWithKey:@"showA" animationCreater:^(DWAnimationMaker *maker) {
//        maker.rotateTo(360).duration(4).install();
//    }];
//    cav.hideAnimation = [cav dw_CreateAnimationWithKey:@"hideA" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(CGPointMake(100, 100)).duration(2).install();
//    }];
//    [cav show];
//    [cav hideAnimation];
    
    [DWMessageHUD showMessage:@"我是一个好宝宝！我是一个好宝宝！我是一个好宝宝！我是一个好宝宝！我是一个好宝宝！我是一个好宝宝！我是一个好宝宝！" font:[UIFont systemFontOfSize:13] numberOfLines:0 toView:self.view limitSize:CGSizeMake(100, 100) autoResize:YES hideDelay:5];
    
}



-(void)btnAction
{
////    [self.hud updateRingStartLoc:0.5 endLoc:1 animated:YES];
//    self.hud.actionType = DWHUDRingIndicatorActionTypeCycle;
////    self.view.bounds = CGRectMake(0, 0, 375, 700);
//    [self.hud startAnimation];
    NSLog(@"click");
//    NSMutableString * string = self.arr.firstObject;
//    [self.arr removeObject:string];
//    NSLog(@"---arr:%@",self.arr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
