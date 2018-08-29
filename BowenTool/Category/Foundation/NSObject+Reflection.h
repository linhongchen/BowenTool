//
//  NSObject+Reflection.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Reflection)

//类名
- (NSString *)ua_className;
+ (NSString *)ua_className;
//父类名称
- (NSString *)ua_superClassName;
+ (NSString *)ua_superClassName;

//实例属性字典
- (NSDictionary *)ua_propertyDictionary;

//属性名称列表
- (NSArray *)ua_propertyKeys;
+ (NSArray *)ua_propertyKeys;

//属性详细信息列表
- (NSArray *)ua_propertiesInfo;
+ (NSArray *)ua_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)ua_propertiesWithCodeFormat;

//方法列表
- (NSArray *)ua_methodList;
+ (NSArray *)ua_methodList;

- (NSArray *)ua_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)ua_registedClassList;
//实例变量
+ (NSArray *)ua_instanceVariable;

//协议列表
- (NSDictionary *)ua_protocolList;
+ (NSDictionary *)ua_protocolList;


- (BOOL)ua_hasPropertyForKey:(NSString *)key;
- (BOOL)ua_hasIvarForKey:(NSString *)key;

@end
