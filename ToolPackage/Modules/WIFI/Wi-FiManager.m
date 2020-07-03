//
//  Wi-FiManager.m
//  ToolPackage
//
//  Created by xing on 2019/11/22.
//  Copyright © 2019 xing. All rights reserved.
//

#import "Wi-FiManager.h"
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface Wi_FiManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *cllocation;

@end

@implementation Wi_FiManager


- (NSString *)getCurrentSSID
{
    if (@available(iOS 13.0, *)) {
        
            //用户明确拒绝，可以弹窗提示用户到设置中手动打开权限
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                NSLog(@"User has explicitly denied authorization for this application, or location services are disabled in Settings.");
                //使用下面接口可以打开当前应用的设置页面
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                return nil;
            }
            CLLocationManager* cllocation = [[CLLocationManager alloc] init];
        _cllocation = cllocation;
        cllocation.delegate = self;
            if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
                //弹框提示用户是否开启位置权限
                [cllocation requestWhenInUseAuthorization];
                NSLog(@"requestWhenInUseAuthorization");
                return nil;
//                usleep(500);
                //递归等待用户选选择
//                return [self getCurrentSSID];
            }
        }

    NSArray* ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    
    NSDictionary *wifiDic = (NSDictionary *)info;
    NSString *ssid = [wifiDic objectForKey:@"SSID"];
    
    return ssid;
}

/** 定位服务状态改变时调用*/
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

@end
