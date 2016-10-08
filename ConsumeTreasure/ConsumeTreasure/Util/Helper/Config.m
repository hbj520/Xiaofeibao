//
//  Config.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "Config.h"

@implementation Config

static Config * instance = nil;
+ (Config *)Instance
{
    @synchronized (self) {
        if(instance == nil){
            [self new];
        }
    }
    return  instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

/**
 *  保存用户信息
 *
 *  @param userid   用户编号
 *  @param username 用户名
 *  @param PhoneNum 用户手机号码
 *  @param token    用户登录令牌
 *  @param icon     用户头像
 */
- (void)saveUserid:(NSString *)userid userName:(NSString *)username userPhoneNum:(NSString *)PhoneNum token:(NSString *)token icon:(NSString *)icon
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults]
    ;
    [settings removeObjectForKey:@"userid"];
    [settings setObject:userid forKey:@"userid"];
    
    [settings removeObjectForKey:@"username"];
    [settings setObject:username forKey:@"username"];
    
    [settings removeObjectForKey:@"phonenum"];
    [settings setObject:PhoneNum forKey:@"phonenum"];
    
    [settings removeObjectForKey:@"token"];
    [settings setObject:token forKey:@"token"];
    
    [settings removeObjectForKey:@"icon"];
    [settings setObject:icon forKey:@"icon"];
    
    [settings synchronize];
}

- (void)saveUsername:(NSString *)username
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"username"];
    [settings setObject:username forKey:@"username"];
    [settings synchronize];
}

- (void)saveImgthumb:(NSString *)imgthumb
               token:(NSString *)token
            username:(NSString *)username
               Money:(NSString *)money
               Ucoin:(NSString *)ucoin
            Integral:(NSString *)integral
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"icon"];
    [settings setObject:imgthumb forKey:@"icon"];
    
    [settings removeObjectForKey:@"token"];
    [settings setObject:token forKey:@"token"];
    
    [settings removeObjectForKey:@"username"];
    [settings setObject:username forKey:@"username"];
    
    [settings removeObjectForKey:@"money"];
    [settings setObject:money forKey:@"money"];
    
    [settings removeObjectForKey:@"ucoin"];
    [settings setObject:ucoin forKey:@"ucoin"];
    
    [settings removeObjectForKey:@"integral"];
    [settings setObject:integral forKey:@"integral"];
    
    [settings synchronize];

}

- (void)saveUcoin:(NSString *)ucoin
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"ucoin"];
    [settings setObject:ucoin forKey:@"ucoin"];
    [settings synchronize];
}

- (void)saveIsteacher:(NSString *)teacher
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"isteacher"];
    [settings setObject:teacher forKey:@"isteacher"];
    
    [settings synchronize];
}

- (void)saveIndex:(NSString *)index
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"index"];
    [settings setObject:index forKey:@"index"];
    
    [settings synchronize];
}



- (void)saveIcon:(NSString *)icon
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"icon"];
    [settings setObject:icon forKey:@"icon"];
    [settings synchronize];
}

- (void)saveBackImg:(NSString *)backimage
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"backimage"];
    [settings setObject:backimage forKey:@"backimage"];
    [settings synchronize];
}
/**
 *  保存密码
 *
 *  @param password 用户密码
 */
- (void)saveUserPassword:(NSString *)password
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"password"];
    [settings setObject:password forKey:@"password"];
    
    [settings synchronize];
    
}
- (void)saveGesturePassword:(NSString *)gesturePassword{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"gesturePassword"];
    [settings setObject:gesturePassword forKey:@"gesturePassword"];
    [settings synchronize];
}
- (void)saveTeminate{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"terminate"];
    [settings setObject:@"1" forKey:@"terminate"];
    [settings synchronize];
}

- (void)saveOrderNum:(NSString *)ordernum
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"ordernum"];
    [settings setObject:ordernum forKey:@"ordernum"];
    [settings synchronize];
}
- (void)saveIsWifi:(NSString *)iswifi{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"iswifi"];
    [settings setObject:iswifi forKey:@"iswifi"];
    [settings synchronize];
}
- (void)savePhoneNum:(NSString *)phoneNum{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"phonenum"];
    [settings setObject:phoneNum forKey:@"phonenum"];
    [settings synchronize];
}
- (NSString *)getisteacher
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"isteacher"];
}
- (NSString *)getTeminate{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"terminate"];
}
- (NSString*)getUserId
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"userid"];
}

- (NSString*)getUserName
{
    NSUserDefaults * settings =[NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"username"];
}

- (NSString*)getPassword
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"password"];
}

- (NSString *)getBackImage
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"backimage"];
}
- (NSString *)getGesturePassword{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"gesturePassword"];
}

- (NSString *)getOrderNum
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"ordernum"];
}
- (NSString *)getIsWifi{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"iswifi"];
}
- (NSString *)getIcon
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"icon"];
}

- (NSString *)getMoney
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"money"];
}

- (NSString *)getUcoin
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"ucoin"];
}

- (NSString *)getIntegral
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"integral"];
}

- (NSString*)getToken
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"token"];
}
- (NSString *)getUserPhoneNum
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"phonenum"];
}

- (void)logout{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"token"];
    [settings removeObjectForKey:@"icon"];
    [settings removeObjectForKey:@"username"];
    [settings removeObjectForKey:@"isteacher"];
    
}
- (void)deleteTeminate{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"terminate"];
}
@end
