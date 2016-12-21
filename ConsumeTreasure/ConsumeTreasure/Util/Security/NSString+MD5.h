//
//  NSString+MD5Encrypt.h
//  Smile
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *)md5Encrypt;

@end
