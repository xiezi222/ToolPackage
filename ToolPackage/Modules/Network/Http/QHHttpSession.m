//
//  QHHttpSession.m
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import "QHHttpSession.h"

static NSInteger kHttpSessionMaxOperation = 3;

@interface QHHttpSession () <QHHttpOperationDelegate>

@property (nonatomic, strong) NSMutableArray *operations;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation QHHttpSession

+ (instancetype)sharedSession
{
    static QHHttpSession *_session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _session = [[QHHttpSession alloc] init];
    });
    return _session;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operations = [[NSMutableArray alloc] init];
        _queue = dispatch_queue_create("com.QHSmartDoorbell.network", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addOperation:(QHHttpOperation *)operation
{
    dispatch_async(self.queue, ^{
        operation.state = QHHttpOperationStateWaiting;
        operation.delegate = self;
        [self.operations addObject:operation];
        [self fire];
    });
}

- (void)cancelOperation:(QHHttpOperation *)operation
{
    dispatch_async(self.queue, ^{

        for (QHHttpOperation *item in self.operations) {
            if ([operation.identifier isEqualToString:item.identifier]) {

                if (item.state == QHHttpOperationStateExecutiving) {
                    [item cancel];
                }
                item.state = QHHttpOperationStateCanceled;
            }
        }
    });
}

- (void)cancelAllOperations
{
    dispatch_async(self.queue, ^{

        for (QHHttpOperation *item in self.operations) {
            if (item.state == QHHttpOperationStateExecutiving) {
                [item cancel];
            }
            item.state = QHHttpOperationStateCanceled;
        }
    });
}

- (void)fire
{
    NSInteger executivingCount = 0;
    for (QHHttpOperation *operation in self.operations) {
        
        if (operation.state == QHHttpOperationStateExecutiving) {
            executivingCount = executivingCount + 1;
        }
        if (executivingCount > kHttpSessionMaxOperation) {
            return;
        }
    }

    for (QHHttpOperation *operation in self.operations) {

        if (operation.state == QHHttpOperationStateWaiting) {
            operation.state = QHHttpOperationStateExecutiving;
            [operation resume];
            return;
        }
    }
}

- (void)removeOperation:(QHHttpOperation *)operation
{
    dispatch_async(self.queue, ^{

        NSMutableArray *invalidOperations = [[NSMutableArray alloc] init];
        for (QHHttpOperation *operation in self.operations) {
            if (operation.state == QHHttpOperationStateFinished ||
                operation.state == QHHttpOperationStateCanceled) {
                [invalidOperations addObject:operation];
            }
        }

        [self.operations removeObjectsInArray:invalidOperations];
    });
}

#pragma mark - QHHttpOperationDelegate

- (void)httpOperationFinished:(QHHttpOperation *)operation
{
    if (operation.state != QHHttpOperationStateCanceled) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (operation.callBack) {
                operation.callBack(operation.responseObject, operation.responseError);
            }
        });
    }
    operation.state = QHHttpOperationStateFinished;
    [self removeOperation:operation];
    [self fire];
}


@end
