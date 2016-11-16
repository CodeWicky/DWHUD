//
//  DWBaseAlert.h
//  DWHUD
//
//  Created by Wicky on 2016/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@interface DWBaseAlert : DWHUDCanvas

///按照key添加按钮
-(void)addButton:(UIButton *)btn withKey:(NSString *)key;

///根据key取出按钮
-(UIButton *)buttonForKey:(NSString *)key;

///根据key移除按钮
-(void)removeBtnForKey:(NSString *)key;
@end
