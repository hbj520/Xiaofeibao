//
//  NSString+URLEncoding.h
//  ailfm
//
//  Created by sunpf on 13-2-3.
//  Copyright (c) 2013年 ailk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OAURLEncodingAdditions) 
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
