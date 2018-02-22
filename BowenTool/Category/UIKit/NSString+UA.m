//
//  NSString+UA.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "NSString+UA.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

#define PhoneRegex       @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[0-9])|(17[0,3,5-8])|(18[0-9])|(147))\\d{8}$"
#define Type_NUMBER      @"0123456789"

@implementation NSString (UA)

- (NSURL *)url
{
    if (!self)
    {
        return [NSURL new];
    }
    
    return [NSURL URLWithString:self];
}


//可能需要中文编码-与上void区分
- (NSURL *)picUrl
{
    if (!self)
    {
        return [NSURL new];
    }
    
    NSString *urlString = self;
    if (![urlString hasPrefix:@"https://"] && ![urlString hasPrefix:@"http://"])
    {
        urlString = [NSString stringWithFormat:@"https://%@", urlString];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"////" withString:@"//"];
    }
    
    return [NSURL URLWithString:urlString];
}

- (NSURL *)picUrlBgc:(NSString *)bgc
{
    if (!self)
    {
        return [NSURL new];
    }
    
    NSString *urlString = self;
    if (![urlString hasPrefix:@"https://"] && ![urlString hasPrefix:@"http://"])
    {
        urlString = [NSString stringWithFormat:@"https://%@", urlString];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"////" withString:@"//"];
    }
    
    if ([urlString hasPrefix:@"https://underarmour.scene7.com/"])
    {
        NSRange bgcRange = [urlString rangeOfString:@"bgc="];
        if (bgcRange.length != 0)
        {
            bgcRange.length = 10;
        }
        
        //存在-防止越界
        if ([urlString substringWithRange:bgcRange])
        {
            NSString *bgcStr = [NSString stringWithFormat:@"bgc=%@", bgc];
            urlString = [urlString stringByReplacingCharactersInRange:bgcRange withString:bgcStr];
        }
    }
    return [NSURL URLWithString:urlString];
}

- (NSNumber *)numberValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:self];
    
    return numTemp;
}

//保留2位小数-向上进位
- (NSString *)scale2Up
{
    return [self scale2WithType:NSRoundUp];
}

- (NSString *)scale2WithType:(NSRoundingMode)roundingMode;
{
    
    return [self scale2WithNextStr:@"0.00" type:roundingMode ruleType:UA_RuleType_Add];
}

- (NSString *)scale2WithNextStr:(NSString *)nextStr
                           type:(NSRoundingMode)roundingMode
                       ruleType:(UA_RuleType)ruleType
{
    //********
    NSDecimalNumber *oneStr1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *twoStr1 = [NSDecimalNumber decimalNumberWithString:nextStr];

    //不存在
    NSDecimal oneDecimal = oneStr1.decimalValue;
    oneStr1 = NSDecimalIsNotANumber(&oneDecimal)?[NSDecimalNumber zero]:oneStr1;
    NSDecimal twoDecimal = twoStr1.decimalValue;
    twoStr1 = NSDecimalIsNotANumber(&twoDecimal)?[NSDecimalNumber zero]:twoStr1;
    
    //********
    NSDecimalNumberHandler *round = [NSDecimalNumberHandler
                                     decimalNumberHandlerWithRoundingMode:roundingMode
                                     scale:2
                                     raiseOnExactness:NO
                                     raiseOnOverflow:NO
                                     raiseOnUnderflow:NO
                                     raiseOnDivideByZero:YES];
    
    //********
    NSDecimalNumber *product = [NSDecimalNumber zero];
    switch (ruleType)
    {
        case UA_RuleType_Add:
        {
            product = [oneStr1 decimalNumberByAdding:twoStr1 withBehavior:round];
        }
            break;
        case UA_RuleType_Reduce:
        {
            product = [oneStr1 decimalNumberBySubtracting:twoStr1 withBehavior:round];
        }
            break;
        case UA_RuleType_Multiply:
        {
            product = [oneStr1 decimalNumberByMultiplyingBy:twoStr1 withBehavior:round];
        }
            break;
        case UA_RuleType_Divid:
        {
            product = [oneStr1 decimalNumberByDividingBy:twoStr1 withBehavior:round];
        }
            break;
        default:
            break;
    }
    
    //***********************************
    NSString *string = [product stringValue];
    if ([string rangeOfString:@"."].length == 0)
    {
        string = [string stringByAppendingString:@".00"];
    }
    else
    {
        NSRange range = [string rangeOfString:@"."];
        if (string.length - range.location - 1 == 2)
        {
            
        }
        else
        {
            string = [string stringByAppendingString:@"0"];
        }
    }

    return string;
}


- (NSString *)uacustomScale2
{
    if (!self || self.hash == @"".hash)
    {
        return @"0.00";
    }
    
    // **************** 任何数字千分分隔，保留小数点后2位
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[self numberValue]];
    
    return formattedNumberString;
}

- (NSString *)replaceEmptyString
{
    if (self && [self length])
    {
        NSString *nameStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return nameStr;
    }
    else
    {
        return self;
    }
}

- (NSString *)componentsSeparatedInString:(NSString *)type
{
    if (self && self.length > 0)
    {
        NSCharacterSet *setToRemove =
        [[NSCharacterSet characterSetWithCharactersInString:type] invertedSet];
        
        NSString *newString =
        [[self componentsSeparatedByCharactersInSet:setToRemove]
         componentsJoinedByString:@""];
        return newString;
    }
    else
    {
        return self;
    }
}


//输入源验证
- (BOOL)typeString:(NSString *)typeStr
{
    if (!self || self.hash == @"".hash)
    {
        return YES;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:typeStr] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL res = [self isEqualToString:filtered];
    
    return res;
}


//正则验证
- (BOOL)regularString:(NSString *)regularStr
{
    if (!self || self.hash == @"".hash)
    {
        return YES;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (CGSize)stringSizeWithFont:(UIFont *)font;
{
    if (!self || self.hash == @"".hash)
    {
        return CGSizeZero;
    }
    
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}


static NSDateFormatter *_formatter = nil;
//+ (NSString *)dateFromFomate:(NSString *)datestring formate:(NSString*)formate
//{
//    NSTimeInterval timeInt = [[self class] timeFromFomate:datestring formate:formate];
//    //时间戳 - NIM -void
//    NSString *timeStr = [NIMKitUtil showTime:timeInt showDetail:NO];
//    NSString *timeStr = [NIMKitUtil showTime:timeInt];
//    return timeStr;
//
//}
/**
 datestring  2017-08-01 23:21:07
 formate     yyyy-MM-dd HH:mm:ss
 return 时间戳
 */
+ (NSTimeInterval)timeWithTimeString:(NSString *)timeString formate:(NSString*)formate
{
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_formatter setLocale:enUS];
    [_formatter setDateFormat:formate];
    NSDate *date = [_formatter dateFromString:timeString];
    return [date timeIntervalSince1970];
    
}

/**
 timeString  2017-08-01 23:21:07
 formate     yyyy-MM-dd HH:mm:ss
 return      特定格式的时间字符串
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString formate:(NSString *)formate
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formate];
    
    // 毫秒值转化为秒
    NSTimeInterval time;
    if (timeString.length == 13)
    {
        time = [timeString integerValue]/1000.0;
    }
    else
    {
        time = [timeString integerValue];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)hubDateString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:[NSDate new]];
}
+ (NSString *)hubDateStringYMDSM
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:[NSDate new]];
}

- (NSString *)hubDateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

+ (NSString *)hubDateStringWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:[NSDate new]];
}

+ (NSString *)uaTimestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.3f", a];//转为字符型
    timeString = [timeString stringByReplacingOccurrencesOfString:@"." withString:@""];
    return timeString;
}


+ (NSString *)hubTimestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    return timeString;
}


#pragma mark - <<<<<< Request >>>>>> -

#pragma mark - <<<<<< TOOL >>>>>> -
- (BOOL)phonePermission
{
    if (self.hash == @"".hash ||
        self.length != 11 )
    {
        return NO;
    }
    return [[self replaceEmptyString] regularString:PhoneRegex];
}

- (BOOL)codePermission
{
    if (self.hash == @"".hash ||
        self.length < 4 ||
        self.length > 6)
    {
        return NO;
    }
    
    return [[self replaceEmptyString] typeString:Type_NUMBER];
}

- (BOOL)namePermission
{
    if (self.hash == @"".hash ||
        self.length < 4 ||
        self.length > 20)
    {
        return NO;
    }
    return YES;
}

- (BOOL)passwordPermission
{
    if (self.hash == @"".hash ||
        self.length < 4 ||
        self.length > 20)
    {
        return NO;
    }
    return YES;
}

#pragma mark - <<<<<< TOOL >>>>>> -


@end
