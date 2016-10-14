//
//  EncryptUtils.h
//  加密工具类
//
//  Created by zjg on 14-9-27.
//  Copyright (c) 2014年 doumee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptUtils : NSObject

+(NSData *)decryptUseDES:(NSData *)cipherText key:(NSString *)key;

+(NSData *) encryptUseDES:(NSData *)plainText key:(NSString *)key;

@end
