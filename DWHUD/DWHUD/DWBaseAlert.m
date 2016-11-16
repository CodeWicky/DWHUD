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

-(void)addButton:(UIButton *)btn withKey:(NSString *)key
{
    [self.btnDic setValue:btn forKey:key];
}

-(UIButton *)buttonForKey:(NSString *)key
{
    return self.btnDic[key];
}

-(void)removeBtnForKey:(NSString *)key
{
    [self.btnDic removeObjectForKey:key];
}

-(NSMutableDictionary *)btnDic
{
    if (!_btnDic) {
        _btnDic = [NSMutableDictionary dictionary];
    }
    return _btnDic;
}



@end
