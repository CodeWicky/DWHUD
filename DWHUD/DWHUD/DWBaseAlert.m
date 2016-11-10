//
//  DWBaseAlert.m
//  DWHUD
//
//  Created by Wicky on 2016/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWBaseAlert.h"

@interface DWBaseAlert ()

@property (nonatomic ,strong) NSMutableDictionary * btnDic;

@end

@implementation DWBaseAlert

-(void)addBtnWithTitle:(UIButton *)title action:(void (^)(DWBaseAlert *))action indentifier:(NSString *)indentifier
{
    [self.btnDic setValue:@{@"title":title,@"action":[NSValue valueWithPointer:(__bridge const void * _Nullable)(action)]} forKey:indentifier];
    void (^bl) (DWBaseAlert *) = [self.btnDic[indentifier][@"action"] pointerValue];
    bl(self);
}

-(NSMutableDictionary *)btnDic
{
    if (!_btnDic) {
        _btnDic = [NSMutableDictionary dictionary];
    }
    return _btnDic;
}

@end
