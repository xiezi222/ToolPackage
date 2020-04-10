//
//  BiometricsLock.h
//  ToolPackage
//
//  Created by xing on 2020/4/10.
//  Copyright © 2020 xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

NS_ASSUME_NONNULL_BEGIN

@interface BiometricsLock : NSObject

- (void)showWithPolicy:(LAPolicy)policy;

@end

NS_ASSUME_NONNULL_END
