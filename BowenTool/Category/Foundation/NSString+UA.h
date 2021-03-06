//
//  NSString+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UA_RuleType_Add,
    UA_RuleType_Reduce,
    UA_RuleType_Multiply,
    UA_RuleType_Divid,
} UA_RuleType;

@interface NSString (UA)

- (NSURL *)url;
- (NSURL *)picUrl;

- (NSNumber *)numberValue;

//保留2位小数-向上进位
- (NSString *)scale2Up;
- (NSString *)scale2WithType:(NSRoundingMode)roundingMode;
- (NSString *)scale2WithNextStr:(NSString *)nextStr
                           type:(NSRoundingMode)roundingMode
                       ruleType:(UA_RuleType)ruleType;

// **************** 任何数字千分分隔，保留小数点后2位
- (NSString *)uacustomScale2;

//去除首尾空格
- (NSString *)replaceEmptyString;


/**
 *  将中文字符串转为拼音
 *
 *  @return 拼音
 */
- (NSString *)ua_pinyinWithChinese;

- (CGSize)stringSizeWithFont:(UIFont *)font;



//时间字符 转 特定时间字符
//+ (NSString *)dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

//时间字符 转 时间戳
+ (NSTimeInterval)timeWithTimeString:(NSString *)timeString formate:(NSString*)formate;

//获取-当前时间-转-hub特定格式的时间字符串
+ (NSString *)hubDateString;

//self-时间戳字符串-转-hub特定格式的时间字符串
- (NSString *)hubDateString;
+ (NSString *)hubDateStringYMDSM;
+ (NSString *)hubDateStringWithDateFormat:(NSString *)dateFormat;


+ (NSString *)uaTimestamp;
+ (NSString *)hubTimestamp;

#pragma mark - <<<<<< TOOL >>>>>> -
- (BOOL)isMobilePhoneNumber;
- (BOOL)phonePermission;
- (BOOL)codePermission;
- (BOOL)namePermission;
- (BOOL)passwordPermission;


#pragma mark - <<<<<< NSMutableAttributedString-TOOL >>>>>> -
- (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)lineSpacing;
- (NSMutableAttributedString *)attributedStringWithHeadIndent:(CGFloat)headIndent;

@end
