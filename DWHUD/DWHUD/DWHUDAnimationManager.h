//
//  DWHUDAnimationManager.h
//  DWHUD
//
//  Created by Wicky on 16/11/9.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DWAnimation;
@interface DWHUDAnimationManager : NSObject
+(DWAnimation *)createFallInAnimationWithView:(UIView *)view;
+(DWAnimation *)createFallOutAnimationWithView:(UIView *)view;
@end
