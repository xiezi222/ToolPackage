//
//  QHSocketMessageHandler.h
//  ToolPackage
//
//  Created by xing on 2019/7/23.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHSocketMessageHandler : NSObject

+ (instancetype)sharedHandler;
- (void)sendMessage:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
