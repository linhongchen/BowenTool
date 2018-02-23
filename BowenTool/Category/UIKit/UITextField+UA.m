//
//  UITextField+UA.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "UITextField+UA.h"

@implementation UITextField (UA)

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    if (placeHolderColor == nil)
    {
        placeHolderColor = [UIColor lightGrayColor];
    }

    //1、
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    /*
    2、
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder?:@"" attributes:
                                      @{NSForegroundColorAttributeName:placeHolderColor,
                                        NSFontAttributeName:self.font}];
    self.attributedPlaceholder = attrString;
     */
}

@end
