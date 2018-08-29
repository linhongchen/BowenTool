//
//  NSMutableAttributedString+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
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

- (void)addLineToString:(NSString *)lineStr;
- (void)addLineSpace:(CGFloat)space;
- (void)addWordSpace:(CGFloat)space;
- (void)addLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

@end
