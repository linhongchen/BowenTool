//
//  NSDictionary+SafeAccess.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/29.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (SafeAccess)

- (BOOL)ua_hasKey:(NSString *)key;

- (NSString*)ua_stringForKey:(id)key;

- (NSNumber*)ua_numberForKey:(id)key;

- (NSDecimalNumber *)ua_decimalNumberForKey:(id)key;

- (NSArray*)ua_arrayForKey:(id)key;

- (NSDictionary*)ua_dictionaryForKey:(id)key;

- (NSInteger)ua_integerForKey:(id)key;

- (NSUInteger)ua_unsignedIntegerForKey:(id)key;

- (BOOL)ua_boolForKey:(id)key;

- (int16_t)ua_int16ForKey:(id)key;

- (int32_t)ua_int32ForKey:(id)key;

- (int64_t)ua_int64ForKey:(id)key;

- (char)ua_charForKey:(id)key;

- (short)ua_shortForKey:(id)key;

- (float)ua_floatForKey:(id)key;

- (double)ua_doubleForKey:(id)key;

- (long long)ua_longLongForKey:(id)key;

- (unsigned long long)ua_unsignedLongLongForKey:(id)key;

- (NSDate *)ua_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)ua_CGFloatForKey:(id)key;

- (CGPoint)ua_pointForKey:(id)key;

- (CGSize)ua_sizeForKey:(id)key;

- (CGRect)ua_rectForKey:(id)key;

@end


#pragma --mark NSMutableDictionary
@interface NSMutableDictionary (SafeAccess)

-(void)ua_setObj:(id)i forKey:(NSString*)key;

-(void)ua_setString:(NSString*)i forKey:(NSString*)key;

-(void)ua_setBool:(BOOL)i forKey:(NSString*)key;

-(void)ua_setInt:(int)i forKey:(NSString*)key;

-(void)ua_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)ua_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)ua_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)ua_setChar:(char)c forKey:(NSString*)key;

-(void)ua_setFloat:(float)i forKey:(NSString*)key;

-(void)ua_setDouble:(double)i forKey:(NSString*)key;

-(void)ua_setLongLong:(long long)i forKey:(NSString*)key;

-(void)ua_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)ua_setSize:(CGSize)o forKey:(NSString*)key;

-(void)ua_setRect:(CGRect)o forKey:(NSString*)key;

@end
