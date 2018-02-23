//
//  UILabel+UA.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "UILabel+UA.h"

@implementation UILabel (UA)

+ (instancetype)getLabel:(CGRect)frame
                fontSize:(int)fontSize
                boldFont:(BOOL)boldFont
               textColor:(UIColor*)textColor
                   align:(NSTextAlignment)align
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = align;
    label.backgroundColor = [UIColor clearColor];
    UIFont *textFont = [UIFont systemFontOfSize:fontSize];
    if (boldFont)
    {
        textFont = [UIFont boldSystemFontOfSize:fontSize];
    }
    label.font = textFont;
    label.textColor = textColor;
    return label;
}

- (void)changeLineSpaceWithLeftRight:(float)space
{
    if (!self.text || self.text.hash == @"".hash) return;
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:labelText];
    NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc] init];
    par.alignment = NSTextAlignmentJustified;
    par.lineSpacing = space;
    NSDictionary *dic = @{NSParagraphStyleAttributeName : par,
                          NSFontAttributeName : self.font,
                          NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]};
    [attributedString setAttributes:dic range:NSMakeRange(0, attributedString.length)];
    self.attributedText = attributedString;
}


/**
 *  改变行间距 + 左右对齐
 */
- (void)changeLineSpaceWithSpace:(float)space
{
    if (!self.text || self.text.hash == @"".hash) return;
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)changeWordSpaceWithSpace:(float)space
{
    if (!self.text || self.text.hash == @"".hash) return;
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    
}

- (void)changeSpaceWithLineSpace:(float)lineSpace wordSpace:(float)wordSpace
{
    if (!self.text || self.text.hash == @"".hash) return;
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (CGSize)lableSize
{
    if (!self.text || self.text.hash == @"".hash) return CGSizeZero;

    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

@end
