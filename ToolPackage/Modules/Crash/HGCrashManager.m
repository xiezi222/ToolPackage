//
//  HGCrashManager.m
//  ToolPackage
//
//  Created by xing on 2019/7/23.
//  Copyright © 2019 xing. All rights reserved.
//

#import "HGCrashManager.h"

@implementation HGCrashManager

+ (void)registerCrashHandler
{
    NSSetUncaughtExceptionHandler(&getException);
}

void getException(NSException *exception) {

    NSLog(@"application exceprion: %@", exception);
}

@end
