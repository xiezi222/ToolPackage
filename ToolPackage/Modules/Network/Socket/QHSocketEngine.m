//
//  QHSocketEngine.m
//  ToolPackage
//
//  Created by xing on 2019/7/22.
//  Copyright © 2019 xing. All rights reserved.
//

#import "QHSocketEngine.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

#define SOCKET_IP "127.0.0.1"
#define SOCKET_PORT 65534

NSNotificationName const QHSocketEngineRevicedMessageNotification = @"QHSocketEngineRevicedMessageNotification";

@interface QHSocketEngine ()

@end

@implementation QHSocketEngine
{
    CFSocketRef _socket;
    dispatch_queue_t _queue;
}

+ (instancetype)sharedEngine
{
    static QHSocketEngine *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[QHSocketEngine alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("com.tool_package.socket", DISPATCH_QUEUE_CONCURRENT);

    }
    return self;
}

- (void)connectToServer
{
    CFSocketContext context = {0,//版本号
                                (__bridge void *)(self),//关联socket 处理回调
                                NULL,//info retain 回调
                                NULL,//info release 回调
                                NULL};//info 回调描述

    struct sockaddr_in socketAddr;
    //memset： 将addr中所有字节用0替代并返回addr，作用是一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法
    memset(&socketAddr, 0, sizeof(socketAddr));
    socketAddr.sin_len = sizeof(socketAddr);
    socketAddr.sin_family = AF_INET;
    socketAddr.sin_port = htons(SOCKET_PORT);
    socketAddr.sin_addr.s_addr = inet_addr(SOCKET_IP);
    CFDataRef addrData = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&socketAddr, sizeof(socketAddr));

    CFOptionFlags flags = kCFSocketConnectCallBack | kCFSocketDataCallBack | kCFSocketWriteCallBack | kCFSocketReadCallBack | kCFSocketAcceptCallBack;
    _socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, flags, SocketCallBack, &context);
    if (_socket == NULL) {
        CFRelease(addrData);
        perror("socket create error:");
        return;
    }

    CFSocketError error = CFSocketConnectToAddress(_socket, addrData, 3);
    CFRelease(addrData);
    if (error != kCFSocketSuccess) {
        perror("socket connect error:");
        return;
    }

    dispatch_async(_queue, ^{
        CFRunLoopRef runloop = CFRunLoopGetCurrent();
        CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, self->_socket, 0);
        CFRunLoopAddSource(runloop, source, kCFRunLoopDefaultMode);
        CFRelease(source);
        CFRunLoopRun();
    });
}

- (void)disconnectServer
{
    CFSocketInvalidate(_socket);
    if (_socket) {
        CFRelease(_socket);
    }
    _socket = NULL;
}

void SocketCallBack(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info)
{
    printf("SocketCallBack type %lu\n", type);
    switch (type) {
        case kCFSocketConnectCallBack: {
            if (data != NULL) {
                printf("socket ConnectCallBack failed\n");
            } else {
                printf("socket ConnectCallBack success\n");
            }
        }
            break;
        case kCFSocketDataCallBack: {
            printf("socket DataCallBack\n");

            NSData *ns_data = (__bridge NSData*)data;
            if (ns_data.length == 0) {
                printf("socket disconnect\n");
                return;
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:QHSocketEngineRevicedMessageNotification object:ns_data];
        }
            break;
        default:
            break;
    }
}

- (BOOL)sendMessage:(NSData *)data
{
    if (!CFSocketIsValid(_socket)) {
        printf("socket can't send message: socket is invalid \n");
        return NO;
    }

    CFDataRef cfdata = CFBridgingRetain(data);
    CFSocketError error = CFSocketSendData(_socket, NULL, cfdata, 0);
    if (error != kCFSocketSuccess) {
        perror("socket send message failed");
        return NO;
    }
    return YES;
}

@end
