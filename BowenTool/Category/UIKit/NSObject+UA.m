//
//  NSObject+UA.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "NSObject+UA.h"

@implementation NSObject (UA)

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
    return 1.5;
}

+ (CGFloat)spaceHeight
{
    return 44;
}

//void ShowHUD(void)
//{
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD show];
//        });
//    }else{
//        [SVProgressHUD show];
//    }
//}
//
//
//void ShowSuccessStatus(NSString *statues){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showSuccessWithStatus:statues];
//        });
//    }else{
//        [SVProgressHUD showSuccessWithStatus:statues];
//    }
//}
//
//
//void ShowMessage(NSString *statues){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showInfoWithStatus:statues];
//        });
//    }else{
//        [SVProgressHUD showInfoWithStatus:statues];
//    }
//}
//
//void ShowErrorStatus(NSString *statues){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:statues];
//        });
//    }else{
//        [SVProgressHUD showErrorWithStatus:statues];
//    }
//}
//
//
//void ShowMaskStatus(NSString *statues){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showWithStatus:statues];
//        });
//    }else{
//        [SVProgressHUD showWithStatus:statues];
//    }
//}
//
//void ShowProgress(CGFloat progress){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showProgress:progress status:@""];
//        });
//    }else{
//        [SVProgressHUD showProgress:progress status:@""];
//    }
//}
//
//void DismissHud(void){
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//    }else{
//        [SVProgressHUD dismiss];
//    }
//}
//
//void ShowError(NSError *error)
//{
//    NSString *statues = @"网络繁忙~请稍后再试";
//    if (error)
//    {
//        //手动取消
//        if (error.domain.hash == @"UA请求失败".hash)
//        {
//            statues = @"网络繁忙~请稍后再试";
//        }
//        else
//        {
//            statues = error.localizedDescription;
//        }
//    }
//    
//    if (![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showErrorWithStatus:statues];
//        });
//    }else{
//        [SVProgressHUD showErrorWithStatus:statues];
//    }
//}

//
//+ (BOOL)isNetworkStatus
//{
//    return [[AFNetworkReachabilityManager sharedManager] isReachable];
//}

//static SystemSoundID sound_male_id = 0;
//+ (void)vibrate
//{
//    if (sound_male_id != 0)
//    {
//        AudioServicesPlaySystemSound(sound_male_id);
//        return;
//    }
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"scanner" ofType:@"wav"];
//    if (path)
//    {
//        //注册声音到系统
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound_male_id);
//        AudioServicesPlaySystemSound(sound_male_id);
//    }
//    else
//    {
//        sound_male_id = 1003;
//        AudioServicesPlaySystemSound(sound_male_id);//播放声音
//    }
//}
//
//+ (void)vishake
//{
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
//}

@end
