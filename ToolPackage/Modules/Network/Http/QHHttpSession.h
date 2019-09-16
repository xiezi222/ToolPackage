//
//  QHHttpSession.h
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHHttpOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface QHHttpSession : NSObject

+ (instancetype)sharedSession;
- (void)addOperation:(QHHttpOperation *)operation;
- (void)cancelOperation:(QHHttpOperation *)operation;
- (void)cancelAllOperations;

@end

NS_ASSUME_NONNULL_END
