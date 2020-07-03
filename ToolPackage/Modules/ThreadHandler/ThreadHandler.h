//
//  ThreadHandler.h
//  ToolPackage
//
//  Created by xing on 2020/6/18.
//  Copyright © 2020 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadHandler : NSObject

+ (void)performBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
