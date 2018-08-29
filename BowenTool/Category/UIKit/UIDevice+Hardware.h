//
//  UIDevice+Hardware.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Hardware)

+ (NSString *)ua_name;
+ (NSString *)ua_mode;
+ (NSString *)ua_localizedModel;
+ (NSString *)ua_systemName;
+ (NSString *)ua_systemVersion;
+ (NSString *)ua_platform;
+ (NSString *)ua_platformString;


+ (NSString *)ua_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)ua_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)ua_busFrequency;
//current device RAM size
+ (NSUInteger)ua_ramSize;
//Return the current device CPU number
+ (NSUInteger)ua_cpuNumber;
//Return the current device total memory


/// 判断当前系统是否有摄像头
+ (BOOL)ua_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)ua_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)ua_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)ua_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)ua_totalDiskSpaceBytes;


@end
