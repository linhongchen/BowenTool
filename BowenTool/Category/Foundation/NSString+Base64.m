//
//  NSString+Base64.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSString+Base64.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Base64)

+ (NSString *)ua_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData ua_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)ua_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data ua_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)ua_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data ua_base64EncodedString];
}
- (NSString *)ua_base64DecodedString
{
    return [NSString ua_stringWithBase64EncodedString:self];
}
- (NSData *)ua_base64DecodedData
{
    return [NSData ua_dataWithBase64EncodedString:self];
}


- (NSString*)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}



/**
 *  MD5加密字符串
 */
- (NSString *)ua_md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    return ret;
}
@end
