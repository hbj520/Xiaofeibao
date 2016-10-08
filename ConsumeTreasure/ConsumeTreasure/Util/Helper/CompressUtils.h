//
//  CompressUtils.h
//  压缩帮助类
//
//  Created by zjg on 14-9-28.
//  Copyright (c) 2014年 doumee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompressUtils : NSObject

+(NSData *)unCompressGZipData:(NSData *)compressedData;

+(NSData*) compressGZipData: (NSData*)pUncompressedData;

@end
