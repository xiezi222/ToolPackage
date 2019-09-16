//
//  QHSocketMessageHandler.m
//  ToolPackage
//
//  Created by xing on 2019/7/23.
//  Copyright © 2019 xing. All rights reserved.
//

#import "QHSocketMessageHandler.h"
#import "QHSocketEngine.h"

@interface QHSocketMessageHandler ()

- (void)getMessage:(NSData *)data;

@end

@implementation QHSocketMessageHandler

+ (instancetype)sharedHandler
{
    static QHSocketMessageHandler *_handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _handler = [[QHSocketMessageHandler alloc] init];
    });
    return _handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSocketMessage:) name:QHSocketEngineRevicedMessageNotification object:nil];
        [[QHSocketEngine sharedEngine] connectToServer];
    }
    return self;
}

- (void)sendMessage:(NSData *)data
{
    [[QHSocketEngine sharedEngine] sendMessage:data];
}

- (void)getSocketMessage:(NSNotification *)notification
{
    NSData *data = notification.object;
    if (data.length) {
        [self getMessage:data];
    }
}

- (void)getMessage:(NSData *)data
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message: %@", message);
}

@end
