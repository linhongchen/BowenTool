//
//  NSMutableAttributedString+UA.m
//  UA EA
//
//  Created by 陈伟财 on 2017/10/28.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "NSMutableAttributedString+UA.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (UA)


+ (instancetype)allocWithString:(NSString *)string
                           font:(UIFont *)font
                          color:(UIColor *)color
{
    return [self allocWithString:string
                            font:font
                           color:color
                       lineColor:nil];
}
+ (instancetype)allocWithString:(NSString *)string
                           font:(UIFont *)font
                          color:(UIColor *)color
                      lineColor:(UIColor *)lineColor
{
    NSMutableDictionary *attributes = [@{NSFontAttributeName:font,
                                         NSForegroundColorAttributeName:color,
                                         } mutableCopy];
    if (lineColor)
    {
        [attributes setObject:[NSNumber numberWithInteger:NSUnderlineStyleSingle] forKey:NSUnderlineStyleAttributeName];
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    NSMutableAttributedString *muattributeStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    
    return muattributeStr;
}


- (void)appendWithString:(NSString *)string
                    font:(UIFont  *)font
                   color:(UIColor *)color
{
    [self appendWithString:string
                      font:font
                     color:color
                 lineColor:nil];
}
- (void)appendWithString:(NSString *)string
                    font:(UIFont  *)font
                   color:(UIColor *)color
               lineColor:(UIColor *)lineColor
{
    NSMutableDictionary *attributes = [@{NSFontAttributeName:font,
                                         NSForegroundColorAttributeName:color,
                                         } mutableCopy];
    if (lineColor)
    {
        [attributes setObject:[NSNumber numberWithInteger:NSUnderlineStyleSingle] forKey:NSUnderlineStyleAttributeName];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    [self appendAttributedString:attributeStr];
}


- (void)addLineSpace:(CGFloat)space
{    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.string length])];
}

- (void)addWordSpace:(CGFloat)space
{
    NSString *string = self.string;
    
    [self addAttribute:NSKernAttributeName value:@(space) range:NSMakeRange(0, [string length])];
}

- (void)addLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace
{
    NSString *string = self.string;
    
    
    [self addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [string length])];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
}

@end
