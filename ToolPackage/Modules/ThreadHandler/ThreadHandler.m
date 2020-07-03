//
//  ThreadHandler.m
//  ToolPackage
//
//  Created by xing on 2020/6/18.
//  Copyright © 2020 xing. All rights reserved.
//

#import "ThreadHandler.h"
#import <objc/runtime.h>

@implementation ThreadHandler

+ (void)performBlock:(dispatch_block_t)block
{
    if (block == NULL) {
        return;
    }
    
//    NSThread *currentThread = [NSThread currentThread];

}

@end
