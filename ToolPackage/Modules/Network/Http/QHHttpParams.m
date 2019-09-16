//
//  QHHttpParams.m
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import "QHHttpParams.h"
#import "QHDevice.h"

@interface QHHttpParams ()

@end

@implementation QHHttpParams

- (instancetype)init
{
    self = [super init];
    if (self) {
        _method = @"POST";
        _timeInterval = 30;
        _needCookies = YES;
    }
    return self;
}

- (NSDictionary *)headerFields
{
    return  @{@"Authorization" : @"Basic: someValue", @"Content-Type" : @"application/json",};

}

- (NSDictionary *)cookies
{
//    DoorbellUserInfo *userInfo = [[DoorbellUserSession sharedSession] getUserInfo];
//    NSString *cookies = [NSString stringWithFormat:@"access_token=%@;", [userInfo.accessToken URLEncoded]];
//    return @{@"Cookie" : cookies};
    return nil;
}

- (NSDictionary *)getClientInfo
{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc] init];
    [parmas setObject:[QHDevice deviceSeries] forKey:@"brand"];
    [parmas setObject:[QHDevice deviceModel] forKey:@"model"];
    [parmas setObject:[QHDevice UDID] forKey:@"imei"];
    [parmas setObject:[QHDevice appVersion] forKey:@"ver"];
    [parmas setObject:[QHDevice systemVersion] forKey:@"ver_platform"];
    [parmas setObject:[QHDevice bundleVersion] forKey:@"ver_build"];
    return parmas;
}

- (NSDictionary *)getParams
{
    NSMutableDictionary *parad = [NSMutableDictionary dictionaryWithDictionary:self.customParams];
    [parad setValue:[[NSUUID UUID] UUIDString] forKey:@"taskid"];
    [parad setValue:[self getClientInfo] forKey:@"clientInfo"];

    NSError *jsonError;
    NSData *jsonData= [NSJSONSerialization dataWithJSONObject:parad options:NSJSONWritingPrettyPrinted error:&jsonError];
    NSString *paradString=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];


    NSMutableDictionary *httpBody = [[NSMutableDictionary alloc] init];
    [httpBody setValue:paradString forKey:@"parad"];
    [parad setValue:@"mpc_cmsdk_ios" forKey:@"from"];
    [httpBody setValue:[QHDevice appVersion] forKey:@"ver"];
    return httpBody;
}


@end
