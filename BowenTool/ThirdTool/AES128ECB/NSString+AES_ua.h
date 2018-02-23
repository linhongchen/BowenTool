//
//  NSString+AES_ua.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES_ua)

- (NSString *)MD5EncodedString;

//md5加密
- (NSString *)md5;

//加密
- (NSString *)encryptAES;

//解密
- (NSString *)decryptAES;

- (NSString *)decryptAESAppIdAppKey_key:(NSString *)key;

@end
