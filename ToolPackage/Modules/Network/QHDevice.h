//
//  QHDevice.h
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHDevice : NSObject

+ (NSString *)systemVersion;
+ (NSString *)deviceModel;
+ (NSString *)deviceSeries;
+ (NSString *)UDID;
+ (NSString *)appVersion;
+ (NSString *)bundleVersion;
+ (NSString *)bundleIdentifier;

@end

NS_ASSUME_NONNULL_END
