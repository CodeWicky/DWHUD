//
//  DWHUDLayout.h
//  DWHUD
//
//  Created by Wicky on 16/10/12.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWHUDLayout
 
 DWHUD负责布局的抽象类。
 实际使用请使用其子类并重写layoutDWHUDComponents方法进行布局
 canvas对象为以本抽象类生成的DWHUDCanvas实例，用于在layoutDWHUDComponents中进行布局
 */

#import <Foundation/Foundation.h>
@interface DWHUDLayout : NSObject
@property (nonatomic ,weak) id canvas;
-(void)layoutDWHUDComponents;
-(void)willShowTheHUD;
-(void)didHideTheHUD;
@end
