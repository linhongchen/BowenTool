//
//  UIColor+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UA)

+ (UIColor *)ua_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ua_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
- (NSString *)ua_HEXString;
///值不需要除以255.0
+ (UIColor *)ua_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)ua_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;


#pragma mark - <<<<<< 随机颜色 >>>>>> -
/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)ua_randomColor;


#pragma mark - <<<<<< 渐变颜色 >>>>>> -
/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)ua_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;



#pragma mark - <<<<<< TOOL >>>>>> -
- (UIColor *)ua_invertedColor;
- (UIColor *)ua_colorForTranslucency;
- (UIColor *)ua_lightenColor:(CGFloat)lighten;
- (UIColor *)ua_darkenColor:(CGFloat)darken;
@end
