//
//  DWBaseAlert.h
//  DWHUD
//
//  Created by Wicky on 2016/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWBaseAlert
 
 基本alert基类
 提供基本型alert的公有方法及属性
 
 version 1.0.0
 提供基本型alert的公有方法及属性
 */

#import "DWHUDCanvas.h"

@interface DWBaseAlert : DWHUDCanvas

///按照key添加按钮
-(void)addButton:(UIButton *)btn withKey:(NSString *)key;

///根据key取出按钮
-(UIButton *)buttonForKey:(NSString *)key;

///根据key移除按钮
-(void)removeBtnForKey:(NSString *)key;
@end
