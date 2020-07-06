//
//  NSData+Category.m
//  ToolPackage
//
//  Created by xing on 2019/9/3.
//  Copyright © 2019 xing. All rights reserved.
//

#import "NSData+Category.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <compression.h>


static NSString *const kAESEncryptKey = @"sfe023f_9fd&fwfl";
static NSString *const kAESEncryptIv = @"sfe023f_9fd&fwfl";

@implementation NSData (Encryption)

- (NSData *)aesEncrypt
{
    return [self aesEncryptWithKey:kAESEncryptKey iv:kAESEncryptIv];
}

- (NSData *)aesDecrypt
{
    return [self aesDecryptWithKey:kAESEncryptKey iv:kAESEncryptIv];
}

- (NSData *)aesEncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    //置字节字符串前n个字节为零且包括‘\0’
    //将NSString 类型的key 转成指定长度的char 类型 存入keyPtr
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCKeySizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;

    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//加密或者解密
                                          kCCAlgorithmAES,//算法
                                          kCCOptionPKCS7Padding,//填充模式 默认cbc模式
                                          keyPtr,//密钥
                                          kCCBlockSizeAES128,//密钥长度
                                          ivPtr,//加密使用的向量参数 cbc 模式需要 ecb 不需要
                                          [self bytes],//输入
                                          dataLength,//输入长度
                                          buffer,//输出
                                          bufferSize,//输出大小
                                          &numBytesEncrypted);//偏移量

    if(cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)aesDecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCKeySizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;

    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,//加密或者解密
                                          kCCAlgorithmAES,//算法
                                          kCCOptionPKCS7Padding,//填充模式 默认cbc模式
                                          keyPtr,//密钥
                                          kCCBlockSizeAES128,//密钥长度
                                          ivPtr,//加密使用的向量参数 cbc 模式需要 ecb 不需要
                                          [self bytes],//输入
                                          dataLength,//输入长度
                                          buffer,//输出
                                          bufferSize,//输出大小
                                          &numBytesEncrypted);//偏移量

    if(cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end




@implementation NSData (Compression)

//buffer 压缩 for 8M以下未压缩/1M以下已压缩
+ (NSData *)compressionData:(NSData *)data {
    
    if (data == nil) return nil;
    
    if (@available(iOS 9.0, *)) {
        
        uint8_t *dstBuffer = (uint8_t *)malloc(data.length);
        memset(dstBuffer, 0, data.length);
        
        size_t resultLength = compression_encode_buffer(dstBuffer, data.length, [data bytes], data.length, NULL, COMPRESSION_LZ4);
        if (resultLength) {
            NSData *compressionData = [NSData dataWithBytes:dstBuffer length:resultLength];
            free(dstBuffer);
            return compressionData;
            
        } else {
            free(dstBuffer);
            return data;
        }
    }
    return data;
}

+ (NSData *)decompressionData:(NSData *)data {
    if (data == nil) return nil;
    if (@available(iOS 9.0, *)) {
        
        uint8_t *dstBuffer = (uint8_t *)malloc(1024*1024*8);
        memset(dstBuffer, 0, data.length);
        
        size_t resultLength = compression_decode_buffer(dstBuffer, 1024*1024*10, [data bytes], data.length, NULL, COMPRESSION_LZ4);
        if (resultLength) {
            NSData *compressionData = [NSData dataWithBytes:dstBuffer length:resultLength];
            free(dstBuffer);
            return compressionData;
            
        } else {
            free(dstBuffer);
            return data;
        }
    }
    return data;
}

@end
