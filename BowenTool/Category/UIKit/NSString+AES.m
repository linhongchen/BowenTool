//
//  NSString+AES.m
//  AES_256
//
//  Created by Mac Mini 10.10 on 16/3/30.
//  Copyright © 2016年 Bison. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "AESCrypt.h"

//加密与解密的秘钥，需要与后台协商共同定义，保持与后台的秘钥相同

@implementation NSString (AES)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)self.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i < 16; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
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
