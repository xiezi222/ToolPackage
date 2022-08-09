//
//  UIDevice+Category.m
//  ToolPackage
//
//  Created by xing on 2021/4/19.
//  Copyright © 2021 xing. All rights reserved.
//

#import "UIDevice+Category.h"
#include <sys/utsname.h>

@implementation UIDevice (Category)

- (NSString *)detailModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    //iPhone
    if ([machine isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([machine isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([machine isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([machine isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([machine isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([machine isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([machine isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([machine isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([machine isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([machine isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([machine isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([machine isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([machine isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([machine isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([machine isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([machine isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([machine isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([machine isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([machine isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([machine isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([machine isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([machine isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([machine isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([machine isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([machine isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([machine isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([machine isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([machine isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([machine isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([machine isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([machine isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([machine isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([machine isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
    if ([machine isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    if ([machine isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([machine isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([machine isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    
    //iPod
    if ([machine isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([machine isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([machine isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([machine isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([machine isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    //iPad
    if ([machine isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([machine isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([machine isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([machine isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([machine isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([machine isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([machine isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([machine isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([machine isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([machine isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([machine isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([machine isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([machine isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([machine isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([machine isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([machine isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([machine isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([machine isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([machine isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([machine isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([machine isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([machine isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([machine isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([machine isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([machine isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([machine isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([machine isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([machine isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([machine isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([machine isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([machine isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    //AppleTV
    if ([machine isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2";
    if ([machine isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([machine isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3";
    if ([machine isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    
    //模拟器
    if ([machine isEqualToString:@"i386"])         return @"Simulator";
    if ([machine isEqualToString:@"x86_64"])       return @"Simulator";
    
    return @"";
}

@end
