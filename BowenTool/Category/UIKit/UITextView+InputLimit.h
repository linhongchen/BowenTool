//
//  UITextView+InputLimit.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (InputLimit)

@property (assign, nonatomic)  NSInteger ua_maxLength;//if <=0, no limit

@end
