//
//  NSString+RegEx.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSString+RegEx.h"

@implementation NSString (RegEx)

#pragma mark - <<<<<< private >>>>>> -
/*! 自己写正则传入进行判断*/
- (BOOL)ua_validateWithRegEx:(NSString *)RegEx
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", RegEx];
    return [predicate evaluateWithObject:self];
}

- (NSString *)ua_componentsSeparatedInString:(NSString *)type
{
    if (self && self.length > 0)
    {
        NSCharacterSet *setToRemove =
        [[NSCharacterSet characterSetWithCharactersInString:type] invertedSet];
        
        NSString *newString =
        [[self componentsSeparatedByCharactersInSet:setToRemove]
         componentsJoinedByString:@""];
        return newString;
    }
    else
    {
        return self;
    }
}


//输入源验证
- (BOOL)ua_typeString:(NSString *)typeStr
{
    if (!self || self.hash == @"".hash)
    {
        return YES;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:typeStr] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL res = [self isEqualToString:filtered];
    
    return res;
}

#pragma mark - <<<<<< publish >>>>>> -
//邮箱
- (BOOL)ua_validateEmail
{
    NSString *RegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self ua_validateWithRegEx:RegEx];
}

//手机号码验证
- (BOOL)ua_validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *RegEx = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    return [self ua_validateWithRegEx:RegEx];
}

//车牌号验证
- (BOOL)ua_validateCarNo
{
    NSString *RegEx = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self ua_validateWithRegEx:RegEx];
}

//车型
- (BOOL)ua_validateCarType
{
    NSString *RegEx = @"^[\u4E00-\u9FFF]+$";
    return [self ua_validateWithRegEx:RegEx];
}

//用户名
- (BOOL)ua_validateUserName
{
    NSString *RegEx = @"^[A-Za-z0-9]{6,20}+$";
    return [self ua_validateWithRegEx:RegEx];
}
//密码
- (BOOL)ua_validatePassword
{
    NSString *RegEx = @"^[a-zA-Z0-9]{6,20}+$";
    return [self ua_validateWithRegEx:RegEx];
}

//昵称
- (BOOL)ua_validateNickname
{
    NSString *RegEx = @"^[\u4e00-\u9fa5]{4,8}$";
    return [self ua_validateWithRegEx:RegEx];
}

//身份证号
- (BOOL)ua_validateIdentityCard
{
    if (self == nil  || self.length == 0) return false;
    
    if (self.length == 18)
    {
        //18位身份证验证
        int factor[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        NSString *parity[] = {@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"};
        
        int sum = 0;
        for (int i = 0; i < 17; i++)
        {
            sum += factor[i] * [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        }
        
        int modValue = sum % 11;
        NSString *last = [self substringFromIndex:17];
        
        if ([[parity[modValue] uppercaseString] isEqualToString:[last uppercaseString]])
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        //15位身份证验证
        NSString *RegEx = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
        return [self ua_validateWithRegEx:RegEx];
    }
}

//手机验证码
- (BOOL)ua_validateCheckCode4
{
    NSString *RegEx = @"\\d{4}";
    return [self ua_validateWithRegEx:RegEx];
}
- (BOOL)ua_validateCheckCode6
{
    NSString *RegEx = @"\\d{6}";
    return [self ua_validateWithRegEx:RegEx];
}

//判断URL是否能够打开
- (void)ua_validateUrlBlock:(void(^)(BOOL))block
{
    NSURL *candidate = [NSURL URLWithString:self];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:candidate];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        NSLog(@"error %@",error);
        if (!request && error)
        {
            NSLog(@"URL不可用");
            block(NO);
        }
        else
        {
            NSLog(@"URL可用:%@",request);
            block(YES);
        }
    }];
    [task resume];
}

@end

