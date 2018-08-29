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

static char base64EncodingTable[64] =
{
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};
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



+ (NSString *)base64StringFromData: (NSData *)data length: (NSUInteger)length
{
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
    {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true)
    {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
        {
            break;
        }
        for (i = 0; i < 3; i++)
        {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
            {
                input[i] = raw[ix];
            }
            else
            {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining)
        {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
        {
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++)
        {
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
        {
            charsonline = 0;
        }
    }
    return result;
}
@end
