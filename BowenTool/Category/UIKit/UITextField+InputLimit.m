//
//  UITextField+InputLimit.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UITextField+InputLimit.h"
#import <objc/runtime.h>

static const void *UATextFieldInputLimitMaxLength = &UATextFieldInputLimitMaxLength;
@implementation UITextField (InputLimit)

- (NSInteger)ua_maxLength
{
    NSNumber *length = objc_getAssociatedObject(self, UATextFieldInputLimitMaxLength);
    return length.integerValue;
}

- (void)setUa_maxLength:(NSInteger)ua_maxLength
{
    objc_setAssociatedObject(self, UATextFieldInputLimitMaxLength, @(ua_maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(ua_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)ua_textFieldTextDidChange
{
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.ua_maxLength > 0 && toBeString.length > self.ua_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.ua_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.ua_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.ua_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.ua_maxLength)
            {
                tmpLength = rangeRange.length - rangeIndex.length;
            }
            else
            {
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

@end
