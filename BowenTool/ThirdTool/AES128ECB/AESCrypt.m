//
//  AESCrypt.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "AESCrypt.h"

#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"

@implementation AESCrypt

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password
{
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptedDataWithKey:password];
    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password
{
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData AES128DecryptedDataWithKey:password];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dicDecrypt:(NSString *)base64EncodedString password:(NSString *)password
{
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData AES128DecryptedDataWithKey:password];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:decryptedData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    return dic;
}
@end
