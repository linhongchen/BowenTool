//
//  UILabel+UA.h
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UA)

+ (instancetype)getLabel:(CGRect)frame
                fontSize:(int)fontSize
                boldFont:(BOOL)boldFont
               textColor:(UIColor*)textColor
                   align:(NSTextAlignment)align;

/**
 *  改变行间距 + 左右对齐
 */
- (void)changeLineSpaceWithLeftRight:(float)space;

/**
 *  改变行间距
 */
- (void)changeLineSpaceWithSpace:(float)space;

/**
 *  改变字间距
 */
- (void)changeWordSpaceWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeSpaceWithLineSpace:(float)lineSpace wordSpace:(float)wordSpace;

//获取lable-font-text-返回的宽度（默认一行）
- (CGSize)lableSize;

@end
