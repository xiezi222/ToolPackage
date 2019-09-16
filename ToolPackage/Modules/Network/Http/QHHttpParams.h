//
//  QHHttpParams.h
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHHttpParams : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, readonly) NSDictionary *headerFields;
@property (nonatomic, readonly) NSDictionary *cookies;
@property (nonatomic, assign) BOOL needCookies;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSDictionary *customParams;

- (NSDictionary *)getParams;

@end

NS_ASSUME_NONNULL_END
