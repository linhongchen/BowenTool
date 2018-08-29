//
//  UIButton+UA.h
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    UAButtonTypeLeft = 0,
    UAButtonTypeTop,
    UAButtonTypeRight,
    UAButtonTypeBottom,
    UAButtonTypeCenter,
} UAButtonType;

typedef enum : NSUInteger {
    UAButtonStyleTop, // image在上，label在下
    UAButtonStyleLeft, // image在左，label在右
    UAButtonStyleBottom, // image在下，label在上
    UAButtonStyleRight // image在右，label在左
} UAButtonStyle;

typedef void(^clickBlock)(UIButton *sender);
@interface UIButton (UA)

@property (nonatomic,copy) clickBlock click;

#pragma mark - <<<<<< 快速instancetype >>>>>> -
+ (instancetype)getButton:(CGRect)frame
                 fontSize:(int)fontSize
                 boldFont:(BOOL)boldFont
                     text:(NSString *)text
                textColor:(UIColor*)textColor;

#pragma mark - <<<<<< 快速添加点击方法 >>>>>> -
- (void)addTarget:(id)target action:(SEL)action;

#pragma mark - <<<<<< ButtonType >>>>>> -
- (void)ua_setbuttonType:(UAButtonType)type;
- (void)ua_layoutButtonWithStyle:(UAButtonStyle)style
                           space:(CGFloat)space;
#pragma mark - <<<<<< 添加下划线 >>>>>> -
- (void)ua_addBottomLine;

#pragma mark - <<<<<< 返回的宽度 >>>>>> -
//获取button-font-text-返回的宽度（默认一行）
- (CGSize)buttonSize;

//通用返回
+ (CGFloat)defaultheight;
+ (UIButton *)sureButtonWithText:(NSString *)text;

@end
