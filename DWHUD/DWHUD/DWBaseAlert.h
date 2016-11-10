//
//  DWBaseAlert.h
//  DWHUD
//
//  Created by Wicky on 2016/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@interface DWBaseAlert : DWHUDCanvas
@property (nonatomic ,strong) NSMutableArray * btnKeysArr;
-(void)addButton:(UIButton *)btn withKey:(NSString *)key;
-(UIButton *)buttonForKey:(NSString *)key;
@end
