//
//  AESCrypt.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCrypt : NSObject

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password;
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;
+ (NSDictionary *)dicDecrypt:(NSString *)base64EncodedString password:(NSString *)password;
@end
