//
//  DWDefaultAlert.h
//  DWHUD
//
//  Created by Wicky on 16/11/10.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/**
 DWDefaultAlert
 
 标准alert类
 提供生成标准alert的api
 
 version 1.0.0
 提供生成标准alert的api
 */

#import "DWBaseAlert.h"

@class DWDefaultAlert;
typedef void(^BtnBlock)(DWDefaultAlert * alert);

@interface DWDefaultAlert : DWBaseAlert

///标题标签
@property (nonatomic ,strong) UILabel * titleLabel;

///描述标签
@property (nonatomic ,strong) UILabel * subTitleLabel;

///图标ImageView
@property (nonatomic ,strong) UIImageView * iconImageView;

///默认按钮
@property (nonatomic ,strong) UIButton * defaultBtn;

///默认按钮回调
@property (nonatomic ,copy) BtnBlock defaultBtnBlock;

///基本初始化方法
/**
 frame              尺寸
 iconImagePath      图片地址（网络本地均可）
 iconSize           图片尺寸
 defaultBtnTitle    默认按钮名称
 title              标题
 titleFont          标题字体
 subTitle           副标题
 subTitleFont       副标题字体
 view               父视图
 btnHeight          按钮高度
 separatorColor     按钮分割线颜色
 margin             组件间距
 */
-(instancetype)initWithFrame:(CGRect)frame iconImagePath:(NSString *)imagePath iconSize:(CGSize)size defaultBtnTitle:(NSString *)defaultBtnTitle title:(NSString *)title titleFont:(UIFont *)titleFont subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitle toView:(UIView *)view btnHeight:(CGFloat)btnHeight separatorColor:(UIColor *)separatorColor margin:(CGFloat)margin;

///初始化一般标题类型alert
-(instancetype)initNormalAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle toView:(UIView *)view;

///初始化一般图标类型alert
-(instancetype)initNormalAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle toView:(UIView *)view;

///初始化标题类型的具有左右按钮的alert
-(instancetype)initWithTitle:(NSString *)title subTilte:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock;

///初始化图标类型的具有左右按钮的alert
-(instancetype)initWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock;

///基本展示方法
+(instancetype)showAlertWithTitle:(NSString *)title titleFont:(UIFont *)titleFont subTitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont toView:(UIView *)view separatorColor:(UIColor *)separatorColor defaultBtnTitle:(NSString *)defaultBtnTitle defaultBtnAction:(void(^)(DWDefaultAlert *))defaultBtnAction;

///展示一般标题类型的alert
+(instancetype)showAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle separatorColor:(UIColor *)separatorColor;

///展示一般图标类型的alert
+(instancetype)showAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle defaultBtnTitle:(NSString *)defaultBtnTitle separatorColor:(UIColor *)separatorColor;

///展示描述型alert
+(instancetype)showAlertWithDescription:(NSString *)description;

///展示标题类型的具有左右按钮的alert
+(instancetype)showAlertWithTitle:(NSString *)title subTilte:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)rightBtnTitle rightBtnBlock:(BtnBlock)rightBtnBlock;

///展示图标类型的具有左右按钮的alert
+(instancetype)showAlertWithIconImagePath:(NSString *)imagePath iconSize:(CGSize)size subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle leftBtnBlock:(BtnBlock)leftBtnBlock rightBtnTitle:(NSString *)riginBtnTitle rigthBtnBlock:(BtnBlock)rigthBtnBlock;
@end
