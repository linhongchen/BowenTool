//
//  NSData+Base64.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSData+Base64.h"

@implementation NSData (Base64)

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)ua_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    NSData *decoded = decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [decoded length]? decoded: nil;
}
/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)ua_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    NSString *encoded = nil;
    switch (wrapWidth)
    {
        case 64:
        {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }
        case 76:
        {
            return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        }
        default:
        {
            encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
        }
    }

    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    return result;
}
/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)ua_base64EncodedString
{
    return [self ua_base64EncodedStringWithWrapWidth:0];
}

@end
