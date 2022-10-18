//
//  UIImage+Category.h
//  ToolPackage
//
//  Created by xing on 2019/8/16.
//  Copyright © 2019 xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (UIColor)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@interface UIImage (QRCode)

- (NSString *)QRCodeFromImage;

@end

@interface UIImage (Compress)

+ (NSData *)compressWithData:(NSData *)imageData;

@end



NS_ASSUME_NONNULL_END
