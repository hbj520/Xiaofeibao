

#import <Foundation/Foundation.h>

@interface MXWechatSignAdaptor : NSObject

+(NSString*)createMd5Sign:(NSDictionary*)dict;
//-(NSString *) md5:(NSString *)str;
@end
