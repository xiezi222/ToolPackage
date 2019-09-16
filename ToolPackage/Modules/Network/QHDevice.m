//
//  QHDevice.m
//  QHSmartDoorbell
//
//  Created by xing on 2019/7/2.
//  Copyright © 2019 360. All rights reserved.
//

#import "QHDevice.h"
//#import "SAMKeychainQuery.h"

#import <sys/sysctl.h>

static NSString *kUDIDAccountName = @"QHSmartDoorbell.udid.accountName";

@implementation QHDevice


+ (NSString *)systemVersion
{
    return nil;
//    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = (NSString *)[NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)deviceSeries
{
    NSString *platform = [self deviceModel];
    if ([platform hasSuffix:@"iPad"]) {
        return @"iPad";
    }
//    NSString *deviceModel = [[self deviceSeriesDictionary] safeStringForKey:platform];
//    return deviceModel;
    return nil;
}

+ (NSDictionary*)deviceSeriesDictionary
{
    static NSDictionary* nameDict = nil;

    if (nameDict == nil)
        {
        nameDict = @{@"iPhone6,1" : @"iPhone5S",
                     @"iPhone6,2" : @"iPhone5S",
                     @"iPhone7,2" : @"iPhone6",
                     @"iPhone7,1" : @"iPhone6 Plus",
                     @"iPhone8,1" : @"iPhone6S",
                     @"iPhone8,2" : @"iPhone6S Plus",
                     @"iPhone8,4" : @"iPhoneSE",
                     @"iPhone9,1" : @"iPhone7",
                     @"iPhone9,2" : @"iPhone7 Plus",
                     @"iPhone10,1" : @"iPhone8",
                     @"iPhone10,4" : @"iPhone8",
                     @"iPhone10,2" : @"iPhone8 Plus",
                     @"iPhone10,5" : @"iPhone8 Plus",
                     @"iPhone10,3" : @"iPhone X",
                     @"iPhone10,6" : @"iPhone X",
                     @"iPhone11,2" : @"iPhone XS",
                     @"iPhone11,4" : @"iPhone XS Max",
                     @"iPhone11,6" : @"iPhone XS Max",
                     @"iPhone11,8" : @"iPhone XR",
                     };
        }

    return nameDict;
}

+ (NSString *)UDID
{
    return nil;
//    SAMKeychainQuery* query = [[SAMKeychainQuery alloc] init];
//    query.service = [QHSmartDoorbellSDKInfo getBundleIdentifier];
//    query.account = kUDIDAccountName;
//    query.accessGroup = [QHSmartDoorbellSDKInfo getAccessGroup];
//
//    NSError *error;
//    [query fetch:&error];
//    NSString *udid = query.password;
//    if (udid.length == 0) {
//        udid = [UIDevice currentDevice].identifierForVendor.UUIDString;
//        query.password = udid;
//        [query save:nil];
//    }
//    return udid;
}

+ (NSString *)appVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *versionNunber = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return versionNunber;
}

+ (NSString *)bundleVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *versionNumber = [infoDict objectForKey:@"CFBundleVersion"];
    return versionNumber;
}

+ (NSString *)bundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

@end
