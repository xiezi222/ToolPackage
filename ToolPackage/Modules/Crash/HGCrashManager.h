//
//  HGCrashManager.h
//  ToolPackage
//
//  Created by xing on 2019/7/23.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

//perror("*****")打印上个函数的error

NS_ASSUME_NONNULL_BEGIN

@interface HGCrashManager : NSObject

+ (void)registerCrashHandler;

@end

NS_ASSUME_NONNULL_END
