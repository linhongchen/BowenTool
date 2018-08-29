//
//  NSObject+AppInfo.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AppInfo)

- (NSString *)ua_version;
- (NSString *)ua_build;
- (NSString *)ua_identifier;
- (NSString *)ua_currentLanguage;
- (NSString *)ua_deviceModel;

@end
