//
//  UIImage+Category.m
//  ToolPackage
//
//  Created by xing on 2019/8/16.
//  Copyright © 2019 xing. All rights reserved.
//

#import "UIImage+Category.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (UIColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

@implementation UIImage (QRCode)

- (NSString *)QRCodeFromImage {
    
    CIImage *ciImage = self.CIImage;
    if (ciImage == nil) {
        return nil;
    }
    
    __block NSString *code = nil;
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:ciImage];
    [features enumerateObjectsUsingBlock:^(CIQRCodeFeature *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.messageString.length) {
            code = obj.messageString;
            *stop = YES;
        }
    }];
    return code;
}

@end
