//
//  QHHttpOperation.h
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QHHttpParams.h"

typedef NS_ENUM(NSUInteger, QHHttpOperationState) {
    QHHttpOperationStateDefault,
    QHHttpOperationStateWaiting,
    QHHttpOperationStateExecutiving,
    QHHttpOperationStateFinished,
    QHHttpOperationStateCanceled
};

NS_ASSUME_NONNULL_BEGIN

@protocol QHHttpOperationDelegate;

@interface QHHttpOperation : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, assign) QHHttpOperationState state;
@property (nonatomic, weak) id<QHHttpOperationDelegate> delegate;
@property (nonatomic, readonly) id responseObject;
@property (nonatomic, readonly) NSError *responseError;
@property (nonatomic, copy) void(^callBack)(id _Nullable responseObject, NSError * _Nullable error);

- (instancetype)initWithParams:(QHHttpParams *)params;
- (void)resume;
- (void)cancel;

@end

@protocol QHHttpOperationDelegate <NSObject>

- (void)httpOperationFinished:(QHHttpOperation *)operation;

@end

NS_ASSUME_NONNULL_END
