//
//  DWBaseAlert.h
//  DWHUD
//
//  Created by Wicky on 2016/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWHUDCanvas.h"

@interface DWBaseAlert : DWHUDCanvas
-(void)addBtnWithTitle:(NSString *)title action:(void(^)(DWBaseAlert *))action indentifier:(NSString *)indentifier;
@end
