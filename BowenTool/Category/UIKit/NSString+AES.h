//
//  NSString+AES.h
//  AES_256
//
//  Created by Mac Mini 10.10 on 16/3/30.
//  Copyright © 2016年 Bison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

//md5加密
- (NSString *)md5;

//加密
- (NSString *)encryptAES;

//解密
- (NSString *)decryptAES;

- (NSString *)decryptAESAppIdAppKey_key:(NSString *)key;

@end
