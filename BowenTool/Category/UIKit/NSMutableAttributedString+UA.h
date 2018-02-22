//
//  NSMutableAttributedString+UA.h
//  UA EA
//
//  Created by 陈伟财 on 2017/10/28.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (UA)


+ (instancetype)allocWithString:(NSString *)string
                           font:(UIFont *)font
                          color:(UIColor *)color;
+ (instancetype)allocWithString:(NSString *)string
                           font:(UIFont *)font
                          color:(UIColor *)color
                      lineColor:(UIColor *)lineColor;

- (void)appendWithString:(NSString *)string
                    font:(UIFont *)font
                   color:(UIColor *)color;
- (void)appendWithString:(NSString *)string
                    font:(UIFont *)font
                   color:(UIColor *)color
               lineColor:(UIColor *)lineColor;

- (void)addLineSpace:(CGFloat)space;
- (void)addWordSpace:(CGFloat)space;
- (void)addLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

@end
