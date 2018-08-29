//
//  NSString+AES.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/29.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

- (NSString *)MD5EncodedString;
//md5加密
- (NSString *)md5;
//加密
- (NSString *)encryptAES;
//解密
- (NSString *)decryptAES;
- (NSString *)decryptAESAppIdAppKey_key:(NSString *)key;


@end
