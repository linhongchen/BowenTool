//
//  NSObject+UA.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSObject+UA.h"

#if __has_include(<SVProgressHUD/SVProgressHUD.h>)
#import <SVProgressHUD/SVProgressHUD.h>
#else
#import "SVProgressHUD.h"
#endif

#import <AudioToolbox/AudioServices.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation NSObject (UA)

- (BOOL)ua_isEmpty
{
    if (self == nil)
    {
        return YES;
    }
    else if ([self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *)self;
        return string.length == 0 ||
        [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 ||
        [string stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 ||
        [string isEqualToString:@"null"]||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"<null>"];
    }
    else if ([self isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray *)self;
        return array.count == 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dic = (NSDictionary *)self;
        return dic.allKeys.count == 0;
    }
    else if ([self isKindOfClass:[NSURL class]])
    {
        NSURL *url = (NSURL *)self;
        return url.absoluteString.hash == @"".hash;
    }
    else
    {
     
    }
    
    return NO;
}


#pragma mark - <<<<<< SVProgress >>>>>> -
void ShowHUD(void)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
    else
    {
        [SVProgressHUD show];
    }
}


void ShowSuccessStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:statues];
    }
}


void ShowMessage(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:statues];
    }
}

void ShowErrorStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:statues];
    }
}


void ShowMaskStatus(NSString *statues)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showWithStatus:statues];
    }
}

void ShowProgress(CGFloat progress)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:progress status:@""];
        });
    }
    else
    {
        [SVProgressHUD showProgress:progress status:@""];
    }
}

void DismissHud(void)
{
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    else
    {
        [SVProgressHUD dismiss];
    }
}

void ShowError(NSError *error)
{
    NSString *statues = @"网络繁忙~请稍后再试";
    if (error)
    {
        //手动取消
        if (error.domain.hash == @"UA请求失败".hash)
        {
            statues = @"网络繁忙~请稍后再试";
        }
        else
        {
            statues = error.localizedDescription;
        }
    }
    
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:statues];
        });
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:statues];
    }
}


#pragma mark - <<<<<< 导航栏/状态栏 >>>>>> -
+ (CGFloat)tabbarHeight
{
    return 49.0;
}

+ (CGFloat)navbarHeight
{
    return 72.0;
}

+ (CGFloat)lineHeight
{
    return 1.;
}

+ (CGFloat)spaceHeight
{
    return 44;
}


#pragma mark - <<<<<< TOOL >>>>>> -
static SystemSoundID sound_male_id = 0;
+ (void)vibrate
{
    if (sound_male_id != 0)
    {
        AudioServicesPlaySystemSound(sound_male_id);
        return;
    }
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"scanner" ofType:@"wav"];
    if (path)
    {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound_male_id);
        AudioServicesPlaySystemSound(sound_male_id);
    }
    else
    {
        sound_male_id = 1003;
        AudioServicesPlaySystemSound(sound_male_id);//播放声音
    }
}

+ (void)vishake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
}


#pragma mark - <<<<<< 指纹识别 >>>>>> -
+ (void)fingerprintIdentificationWithSuccess:(void(^)(void))successful fail:(void(^)(NSError *))fail
{
    float version = [UIDevice currentDevice].systemVersion.floatValue;
    // 判断当前系统版本
    if (version < 8.0 )
    {
        NSLog(@"系统版本太低,请升级至最新系统");
        return;
    }
    // 1> 实例化指纹识别对象
    LAContext *laCtx = [[LAContext alloc] init];
    
    // 2> 判断当前设备是否支持指纹识别功能.
    if (![laCtx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL])
    {
        // 如果设备不支持指纹识别功能
        NSLog(@"该设备不支持指纹识别功能");
        return;
    };
    [laCtx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹登陆" reply:^(BOOL success, NSError *error)
    {
        // 如果成功,表示指纹输入正确.
        if (success)
        {
            NSLog(@"指纹识别成功!");
            successful();
        }
        else
        {
            NSLog(@"指纹识别错误,请再次尝试");
            fail(error);
        }
    }];
}

@end
