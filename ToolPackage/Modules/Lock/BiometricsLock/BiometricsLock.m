//
//  BiometricsLock.m
//  ToolPackage
//
//  Created by xing on 2020/4/10.
//  Copyright © 2020 xing. All rights reserved.
//

#import "BiometricsLock.h"

@implementation BiometricsLock

- (void)showWithPolicy:(LAPolicy)policy
{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"切换到密码";
    if (@available(iOS 10.0, *)) {
        context.localizedCancelTitle = @"算了";
    }

    NSError *error;
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"您还没有进行指纹输入，请指纹设定后打开");
                break;
                
            case  LAErrorTouchIDNotAvailable:
                NSLog(@"您的设备不支持指纹输入，请切换为数字键盘");
                break;
                
            case LAErrorPasscodeNotSet:
                NSLog(@"您还没有设置密码输入");
                break;
                
            default:
                break;
        }
        return;
    }
    
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"手机指纹验证..."
                      reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            NSLog(@"验证 Success");
        } else {
            switch (error.code) {
                case LAErrorUserCancel:
                    //认证被用户取消.例如点击了 cancel 按钮.
                    NSLog(@"密码取消");
                    break;
                    
                case LAErrorAuthenticationFailed:
                    // 此处会自动消失，然后下一次弹出的时候，又需要验证数字
                    // 认证没有成功,因为用户没有成功的提供一个有效的认证资格
                    NSLog(@"连输三次后，密码失败");
                    break;
                    
                case LAErrorPasscodeNotSet:
                    // 认证不能开始,因为此台设备没有设置密码.
                    NSLog(@"密码没有设置");
                    break;
                    
                case LAErrorSystemCancel:
                    //认证被系统取消了(例如其他的应用程序到前台了)
                    NSLog(@"系统取消了验证");
                    break;
                    
                case LAErrorUserFallback:
                    //当输入觉的会有问题的时候输入
                    NSLog(@"登陆");
                    break;
                    
                case LAErrorTouchIDNotAvailable:
                    //认证不能开始,因为 touch id 在此台设备尚是无效的.
                    NSLog(@"touch ID 无效");
                    break;
                    
                default:
                    NSLog(@"您不能访问私有内容");
                    break;
            }
        }
    }];
}

@end
