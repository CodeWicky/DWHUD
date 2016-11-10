//
//  DWDefaultAlert.m
//  DWHUD
//
//  Created by Wicky on 16/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "DWDefaultAlert.h"
#import "DWDefaultAlertLayout.h"

@interface DWDefaultAlert ()

@property (nonatomic ,strong) NSMutableArray * btnKeysArray;

@end

@implementation DWDefaultAlert


-(void)addButton:(UIButton *)btn withKey:(NSString *)key
{
    [super addButton:btn withKey:key];
    [self.btnKeysArray addObject:key];
}

-(NSMutableArray *)btnKeysArray
{
    if (!_btnKeysArray) {
        _btnKeysArray = [NSMutableArray array];
    }
    return _btnKeysArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    DWDefaultAlertLayout * layout = [[DWDefaultAlertLayout alloc] init];
    self = [super initWithFrame:frame layout:layout];
    return self;
}

@end
