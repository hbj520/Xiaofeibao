//
//  EncryptUtils.m
//  zbom
//
//  Created by zjg on 14-9-27.
//  Copyright (c) 2014年 doumee. All rights reserved.
//

#import "EncryptUtils.h"


#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation EncryptUtils
 const Byte iv[] = {1,2,3,4,5,6,7,8};

#pragma mark des加密
 +(NSData *) encryptUseDES:(NSData *)textData key:(NSString *)key
 {
        NSData *data = nil;
        NSData *resultData = nil;
        NSUInteger dataLength = [textData length];
         unsigned char buffer[1024];
         memset(buffer, 0, sizeof(char));
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                           kCCOptionPKCS7Padding,
                                           [key UTF8String], kCCKeySizeDES,
                                           iv,
                                           [textData bytes], dataLength,
                                           buffer, 1024,
                                           &numBytesEncrypted);
     if (cryptStatus == kCCSuccess) {
         data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
         
         resultData = [GTMBase64 encodeData:data];
     }
     
     return resultData;
}

#pragma mark des解密
+(NSData *)decryptUseDES:(NSData *)cipherText key:(NSString *)key
{
    NSData *plaindata = nil;
    NSData *cipherdata = [GTMBase64 decodeData:cipherText];
    unsigned char buffer[65535];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, sizeof(buffer),
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
    }
    
    return plaindata;
}

@end
