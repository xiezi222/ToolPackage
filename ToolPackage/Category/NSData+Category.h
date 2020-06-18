//
//  NSData+Category.h
//  ToolPackage
//
//  Created by xing on 2019/9/3.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Encryption)

- (NSData *)aesEncrypt;
- (NSData *)aesDecrypt;

@end

@interface NSData (Compression)

+ (NSData *)compressionData:(NSData *)data;
+ (NSData *)decompressionData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
