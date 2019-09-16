//
//  NSString+Category.m
//  ToolPackage
//
//  Created by xing on 2019/9/3.
//  Copyright © 2019 xing. All rights reserved.
//

#import "NSString+Category.h"
#import "NSData+Category.h"

@implementation NSString (Encryption)

- (NSString *)aesEncrypt
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [data aesEncrypt];
    return [encryptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)aesDecrypt
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *decryptData = [data aesDecrypt];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

@end
