

//
//  UITextView+InputLimit.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UITextView+InputLimit.h"
#import <objc/runtime.h>

static const void *UATextViewInputLimitMaxLength = &UATextViewInputLimitMaxLength;

@implementation UITextView (InputLimit)

- (NSInteger)ua_maxLength
{
    return [objc_getAssociatedObject(self, UATextViewInputLimitMaxLength) integerValue];
}

- (void)setUa_maxLength:(NSInteger)ua_maxLength
{
    objc_setAssociatedObject(self, UATextViewInputLimitMaxLength, @(ua_maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ua_textViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];
    
}

- (void)ua_textViewTextDidChange:(NSNotification *)notification
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
