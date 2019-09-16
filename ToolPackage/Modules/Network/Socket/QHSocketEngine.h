//
//  QHSocketEngine.h
//  ToolPackage
//
//  Created by xing on 2019/7/22.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSNotificationName const QHSocketEngineRevicedMessageNotification;

@interface QHSocketEngine : NSObject

+ (instancetype)sharedEngine;
- (void)connectToServer;
- (void)disconnectServer;
- (BOOL)sendMessage:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
