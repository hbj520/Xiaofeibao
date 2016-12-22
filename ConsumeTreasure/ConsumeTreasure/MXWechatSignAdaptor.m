/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return MXWechatSignAdaptor（微信签名工具类）
 */

#import "MXWechatSignAdaptor.h"
#import <CommonCrypto/CommonDigest.h>

@interface MXWechatSignAdaptor()

@end

@implementation MXWechatSignAdaptor

#pragma mark - Life Cycle

//签名算法
+(NSString*)createMd5Sign:(NSDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    
    NSArray *keys = [dict allKeys];
    
    //1.按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //2.拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (   ![dict[categoryId] isEqualToString:@""]
            && ![dict[categoryId] isEqualToString:@"sign"]
            && ![dict[categoryId] isEqualToString:@"key"])
        {
            [contentString appendFormat:@"%@=%@&", categoryId, dict[categoryId]];
        }
    }
      [contentString appendFormat:@"key=%@",@"XFB@96478YY"];

         
    return contentString;
    
}


@end
