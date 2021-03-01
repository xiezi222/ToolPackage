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
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
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

@implementation UIImage (Type)


//+ (SDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data {
//    if (!data) {
//        return SDImageFormatUndefined;
//    }
//    
//    // File signatures table: http://www.garykessler.net/library/file_sigs.html
//    uint8_t c;
//    [data getBytes:&c length:1];
//    switch (c) {
//        case 0xFF:
//            return SDImageFormatJPEG;
//        case 0x89:
//            return SDImageFormatPNG;
//        case 0x47:
//            return SDImageFormatGIF;
//        case 0x49:
//        case 0x4D:
//            return SDImageFormatTIFF;
//        case 0x52: {
//            if (data.length >= 12) {
//                //RIFF....WEBP
//                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
//                if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
//                    return SDImageFormatWebP;
//                }
//            }
//            break;
//        }
//        case 0x00: {
//            if (data.length >= 12) {
//                //....ftypheic ....ftypheix ....ftyphevc ....ftyphevx
//                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
//                if ([testString isEqualToString:@"ftypheic"]
//                    || [testString isEqualToString:@"ftypheix"]
//                    || [testString isEqualToString:@"ftyphevc"]
//                    || [testString isEqualToString:@"ftyphevx"]) {
//                    return SDImageFormatHEIC;
//                }
//                //....ftypmif1 ....ftypmsf1
//                if ([testString isEqualToString:@"ftypmif1"] || [testString isEqualToString:@"ftypmsf1"]) {
//                    return SDImageFormatHEIF;
//                }
//            }
//            break;
//        }
//        case 0x25: {
//            if (data.length >= 4) {
//                //%PDF
//                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(1, 3)] encoding:NSASCIIStringEncoding];
//                if ([testString isEqualToString:@"PDF"]) {
//                    return SDImageFormatPDF;
//                }
//            }
//        }
//        case 0x3C: {
//            if (data.length > 100) {
//                // Check end with SVG tag
//                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(data.length - 100, 100)] encoding:NSASCIIStringEncoding];
//                if ([testString containsString:kSVGTagEnd]) {
//                    return SDImageFormatSVG;
//                }
//            }
//        }
//    }
//    return SDImageFormatUndefined;
//}
//
//+ (nonnull CFStringRef)sd_UTTypeFromImageFormat:(SDImageFormat)format {
//    CFStringRef UTType;
//    switch (format) {
//        case SDImageFormatJPEG:
//            UTType = kUTTypeJPEG;
//            break;
//        case SDImageFormatPNG:
//            UTType = kUTTypePNG;
//            break;
//        case SDImageFormatGIF:
//            UTType = kUTTypeGIF;
//            break;
//        case SDImageFormatTIFF:
//            UTType = kUTTypeTIFF;
//            break;
//        case SDImageFormatWebP:
//            UTType = kSDUTTypeWebP;
//            break;
//        case SDImageFormatHEIC:
//            UTType = kSDUTTypeHEIC;
//            break;
//        case SDImageFormatHEIF:
//            UTType = kSDUTTypeHEIF;
//            break;
//        case SDImageFormatPDF:
//            UTType = kUTTypePDF;
//            break;
//        case SDImageFormatSVG:
//            UTType = kUTTypeScalableVectorGraphics;
//            break;
//        default:
//            // default is kUTTypeImage abstract type
//            UTType = kUTTypeImage;
//            break;
//    }
//    return UTType;
//}
//
//+ (SDImageFormat)sd_imageFormatFromUTType:(CFStringRef)uttype {
//    if (!uttype) {
//        return SDImageFormatUndefined;
//    }
//    SDImageFormat imageFormat;
//    if (CFStringCompare(uttype, kUTTypeJPEG, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatJPEG;
//    } else if (CFStringCompare(uttype, kUTTypePNG, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatPNG;
//    } else if (CFStringCompare(uttype, kUTTypeGIF, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatGIF;
//    } else if (CFStringCompare(uttype, kUTTypeTIFF, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatTIFF;
//    } else if (CFStringCompare(uttype, kSDUTTypeWebP, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatWebP;
//    } else if (CFStringCompare(uttype, kSDUTTypeHEIC, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatHEIC;
//    } else if (CFStringCompare(uttype, kSDUTTypeHEIF, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatHEIF;
//    } else if (CFStringCompare(uttype, kUTTypePDF, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatPDF;
//    } else if (CFStringCompare(uttype, kUTTypeScalableVectorGraphics, 0) == kCFCompareEqualTo) {
//        imageFormat = SDImageFormatSVG;
//    } else {
//        imageFormat = SDImageFormatUndefined;
//    }
//    return imageFormat;
//}

@end
