//
//  NSString+Category.h
//  ToolPackage
//
//  Created by xing on 2019/9/3.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encryption)

- (NSString *)aesEncrypt;
- (NSString *)aesDecrypt;

@end

NS_ASSUME_NONNULL_END
