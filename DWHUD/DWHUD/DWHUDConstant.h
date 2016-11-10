//
//  DWHUDConstant.h
//  DWHUD
//
//  Created by Wicky on 16/10/29.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#ifndef DWHUDConstant_h
#define DWHUDConstant_h

typedef NS_OPTIONS(NSInteger , DWHUDAnimatoinType) {///DWHUD动画形式
    DWHUDAnimatoinTypeNone = 0,///取消动画
    DWHUDAnimatoinTypeFallIn = 1 << 0,///坠入
    DWHUDAnimatoinTypeFallOut = 1 << 1,///落出
    DWHUDAnimatoinTypeFlyIn = 1 << 2,///飞入
    DWHUDAnimatoinTypeFlyOut = 1 << 3,///飞出
    DWHUDAnimatoinTypeZoomIn = 1 << 4,///缩放进入
    DWHUDAnimatoinTypeZoomOut = 1 << 5,///缩放
};

//宏输出函数

#ifdef DEBUG

#define DWLog(fmt, ...) NSLog((@"%s," "[lineNum:%d]" fmt) , __FUNCTION__, __LINE__, ##__VA_ARGS__); //带函数名和行数


#else

#define DWLog(fmt, ...)

#endif

///weakSelf
#define WEAKSELF __weak typeof(self)weakSelf = self;

#define APPWindow [[[UIApplication sharedApplication] delegate] window]

#define APPRootView APPWindow.rootViewController.view



#endif /* DWHUDConstant_h */
