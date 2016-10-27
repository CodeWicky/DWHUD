//
//  DWHUDRingIndicator.h
//  DWHUD
//
//  Created by Wicky on 16/10/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,DWHUDRingIndicatorActionType) {
    DWHUDRingIndicatorActionTypeDefault,
    DWHUDRingIndicatorActionTypeCycle,
    DWHUDRingIndicatorActionTypeRotateCycle,
    DWHUDRingIndicatorActionTypePercent
};

@interface DWHUDRingIndicator : UIView

///百分比文字颜色
@property (nonatomic ,strong) UIColor * textColor;

///进度
@property (nonatomic ,assign) CGFloat progress;

///百分比标签
@property (nonatomic ,strong) UILabel * lbPercent;

///动画风格
@property (nonatomic ,assign) DWHUDRingIndicatorActionType actionType;

///生成环形指示器实例
-(instancetype)initWithFrame:(CGRect)frame
            needPercentLabel:(BOOL)needPercentLabel;

-(void)updateRingStartLoc:(CGFloat)startLoc
                   endLoc:(CGFloat)endLoc
                 animated:(BOOL)animated;
@end
