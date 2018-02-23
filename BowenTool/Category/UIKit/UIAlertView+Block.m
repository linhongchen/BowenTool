//
//  UIAlertView+Block.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "UIAlertView+Block.h"

#import <objc/runtime.h>

static char kUIAlertViewBlockAddress;

@interface UIAlertView ()<UIAlertViewDelegate>
@end
@implementation UIAlertView (Block)
- (void)showAlertWithCompletionHandler: (void (^)(NSInteger))block
{
    self.delegate = self;
    objc_setAssociatedObject(self,&kUIAlertViewBlockAddress,block,OBJC_ASSOCIATION_COPY);
    [self show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AlertBlock block = objc_getAssociatedObject(self, &kUIAlertViewBlockAddress);
    if (block)
    {
        block(buttonIndex);
        objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
}

- (void)clearActionBlock
{
    self.delegate = nil;
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
}

@end
