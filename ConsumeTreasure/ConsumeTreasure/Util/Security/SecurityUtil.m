//
//  SecurityUtil.h
//  Smile
//

#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#import "NSString+MD5.h"
#import "StringEncryption.h"
#import "NSData+Base64.h"

#define APP_PUBLIC_PASSWORD     @"boundary"

@implementation SecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input {
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
	return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]; 
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSData*)encryptAESData:(NSString*)string {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:APP_PUBLIC_PASSWORD];
    return encryptedData;
}

//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data {
    //使用密码对data进行解密
    NSData *decryData = [data AES256DecryptWithKey:APP_PUBLIC_PASSWORD];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return [string autorelease];
}

#pragma mark - MD5加密
/**
 *	@brief	对string进行md5加密
 *
 *	@param 	string 	未加密的字符串
 *
 *	@return	md5加密后的字符串
 */
+ (NSString*)encryptMD5String:(NSString*)string {
    
    
    
    
    return [string md5Encrypt];
}



//解密文件
+(BOOL) DecryptFileAES:(NSString *) srcfilepath destfilepath:(NSString *)destfilepath key:(NSString *) key
{
    BOOL success=YES;
    NSFileHandle *srcfile;// = [NSFileHandle fileHandleForReadingAtPath:srcfilepath];
    NSFileHandle *desfile;// = [NSFileHandle fileHandleForWritingAtPath:srcfilepath];
    CCOptions padding = kCCOptionPKCS7Padding;
    StringEncryption *crypto = [[StringEncryption alloc] init];
    
    @try {
        srcfile = [NSFileHandle fileHandleForReadingAtPath:srcfilepath];
//        NSFileManager *myFileManager=[NSFileManager defaultManager];
//        NSDictionary *attributes=[myFileManager fileAttributesAtPath:srcfilepath traverseLink:NO];
//        if(attributes==nil)
//            return false;
//        unsigned long long sizeTotal=[[attributes objectForKey:NSFileSize] intValue]; //文件总长度

        [[NSFileManager defaultManager] createFileAtPath:destfilepath contents:nil attributes:nil];
        desfile = [NSFileHandle fileHandleForWritingAtPath:destfilepath];
        if(desfile == nil)
            return false;
//        [desfile truncateFileAtOffset:0];      
//        int size=2048;
//        int loops=0;
//        
//        unsigned long long offset=0;   //当前偏移位置
//        BOOL loop=YES;
//        unsigned long long lastOffSet=0;    //上一次偏移位置
//        while(loop){
//            offset=size*(loops++);  //设置偏移量
//            if(offset>=sizeTotal){
//                offset=sizeTotal;
//                size=offset-lastOffSet;
//                loop=NO;
//            }
//            lastOffSet=offset;
//            
//            [srcfile seekToFileOffset:offset];
//            NSData * buffer=[srcfile readDataOfLength:size];
//            NSData *data = [crypto decrypt:buffer key:[key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
//            [desfile seekToEndOfFile];
//            [desfile writeData:data];
//        }
        
        NSData * buffer=[srcfile readDataToEndOfFile];
        NSData *data = [crypto decrypt:buffer key:[key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
        [desfile writeData:data];
        
    }
    @catch (NSException *exception) {
        NSLog(@"DecryptFileAES_ERR:%@",exception);
        success=NO;
    }
    @finally {
        [srcfile closeFile];
        [desfile closeFile];
    }
    return success;
}

@end
