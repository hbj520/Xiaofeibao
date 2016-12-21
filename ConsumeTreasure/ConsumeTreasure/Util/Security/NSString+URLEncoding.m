//
//  NSString+URLEncoding.m
//  ailfm
//
//  Created by sunpf on 13-2-3.
//  Copyright (c) 2013年 ailk. All rights reserved.
//

#import "NSString+URLEncoding.h"
#import <Foundation/Foundation.h>
@implementation  NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&amp;=+$,/?%#[] "),
                                            kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    NSMutableString *outPutString = [result mutableCopy];
    [outPutString replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outPutString length])];
    [result autorelease];
    return outPutString;
}
@end