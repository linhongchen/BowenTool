//
//  UITextField+Select.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Select)

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)ua_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)ua_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)ua_setSelectedRange:(NSRange)range;

@end
