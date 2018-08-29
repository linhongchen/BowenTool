//
//  NSString+AES.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/29.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "AESCrypt.h"

//加密与解密的秘钥，需要与后台协商共同定义，保持与后台的秘钥相同
@implementation NSString (AES)

- (NSString *)md5
{
    if (self == nil || [self length] == 0)
    {
        return nil;
    }
    
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)self.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i < 16; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

- (NSString *)MD5EncodedString
{
    if (self == nil || [self length] == 0)
    {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)encryptAES
{
    NSString *value = [AESCrypt encrypt:self password:@""];
    
    return value;
}

- (NSString *)decryptAES
{
    NSString *value = [AESCrypt decrypt:self password:@""];
    
    return value;
}

- (NSDictionary *)dicDecryptAES
{
    NSDictionary *dic = [AESCrypt dicDecrypt:self password:@""];
    return dic;
}


- (NSString *)decryptAESAppIdAppKey_key:(NSString *)key
{
    NSString *newKey = [NSString stringWithFormat:@"%@%@", key, @"&&"];
    NSString *value = [AESCrypt decrypt:self password:newKey];
    return value;
}

@end
