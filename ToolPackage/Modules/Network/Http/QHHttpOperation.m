//
//  QHHttpOperation.m
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import "QHHttpOperation.h"


@interface QHHttpOperation ()

@property (nonatomic, strong) QHHttpParams *parmas;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSURLSession *sesstion;

@property (nonatomic, readwrite) id responseObject;
@property (nonatomic, readwrite) NSError *responseError;

@end

@implementation QHHttpOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = QHHttpOperationStateDefault;
        _identifier = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (instancetype)initWithParams:(QHHttpParams *)params
{
    self = [super init];
    if (self) {
        _parmas = params;
        [self initSession];
    }
    return self;
}

- (void)initSession
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:_parmas.headerFields];
    [headers addEntriesFromDictionary:_parmas.cookies];
    configuration.HTTPAdditionalHeaders = headers;
    configuration.HTTPShouldSetCookies = _parmas.needCookies;
    configuration.timeoutIntervalForRequest = _parmas.timeInterval;

    self.sesstion = [NSURLSession sessionWithConfiguration:configuration];
}

- (void)resume
{
    self.state = QHHttpOperationStateExecutiving;

    __weak typeof(self) weakSelf = self;

    NSURL *URL = [NSURL URLWithString:_parmas.url];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";

    NSData *data= [NSJSONSerialization dataWithJSONObject:self.parmas.getParams options:NSJSONWritingPrettyPrinted error:nil];

    request.HTTPBody = data;

    self.task = [self.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error != nil) {
            weakSelf.responseError = error;
        } else {
            weakSelf.responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        }

        if([weakSelf.delegate respondsToSelector:@selector(httpOperationFinished:)]) {
            [weakSelf.delegate httpOperationFinished:weakSelf];
        }
        [weakSelf.sesstion invalidateAndCancel];
    }];

    [self.task resume];
}

- (void)cancel
{
    [self.task cancel];
}

@end
