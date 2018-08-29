//
//  NSFileManager+Path.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/29.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSFileManager+Path.h"

@implementation NSFileManager (Path)

+ (NSURL *)ua_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)ua_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)ua_documentsURL
{
    return [self ua_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)ua_documentsPath
{
    return [self ua_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)ua_libraryURL
{
    return [self ua_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)ua_libraryPath
{
    return [self ua_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)ua_cachesURL
{
    return [self ua_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)ua_cachesPath
{
    return [self ua_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)ua_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)ua_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.ua_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end

