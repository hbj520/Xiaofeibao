//
//  XFBConfig.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "XFBConfig.h"

@implementation XFBConfig
static XFBConfig * instance = nil;
+ (XFBConfig *)Instance
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
    
    [settings removeObjectForKey:@"phone"];
    [settings setObject:PhoneNum forKey:@"phone"];
    
    [settings removeObjectForKey:@"token"];
    [settings setObject:token forKey:@"token"];
    
    [settings removeObjectForKey:@"icon"];
    [settings setObject:icon forKey:@"icon"];
    
    [settings synchronize];
}
- (void)saveImgUrl:(NSString *)imgUrl
             token:(NSString *)token
         loginName:(NSString *)loginName
           balance:(NSString *)balance
            qrCode:(NSString *)qrCode
             phone:(NSString *)phone{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults]
    ;
    [settings removeObjectForKey:@"icon"];
    [settings setObject:imgUrl forKey:@"icon"];
    
    [settings removeObjectForKey:@"token"];
    [settings setObject:token forKey:@"token"];
    
    [settings removeObjectForKey:@"username"];
    [settings setObject:loginName forKey:@"username"];
    
    [settings removeObjectForKey:@"balance"];
    [settings setObject:balance forKey:@"balance"];
    
    [settings removeObjectForKey:@"qrCode"];
    [settings setObject:qrCode forKey:@"qrCode"];
    
    [settings removeObjectForKey:@"phone"];
    [settings setObject:phone forKey:@"phone"];
    
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
    [settings removeObjectForKey:@"phone"];
    [settings setObject:phoneNum forKey:@"phone"];
    [settings synchronize];
}
- (void)saveCityCode:(NSString *)cityCode{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"cityCode"];
    [settings setObject:cityCode forKey:@"cityCode"];
    [settings synchronize];
}

- (void)saveIsShop:(NSString*)isShop{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"isShop"];
    [settings setObject:isShop forKey:@"isShop"];
    [settings synchronize];
}

- (void)saveIsAgency:(NSString*)isAgency{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"isAgency"];
    [settings setObject:isAgency forKey:@"isAgency"];
    [settings synchronize];
}

- (void)saveloginName:(NSString*)name{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"loginName"];
    [settings setObject:name forKey:@"loginName"];
    [settings synchronize];
}
- (void)saveVersion:(NSString *)version{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"version"];
    [settings setObject:version forKey:@"version"];
    [settings synchronize];
}

- (void)saveMemId:(NSString*)memId{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"memid"];
    [settings setObject:memId forKey:@"memid"];
    [settings synchronize];
}


//是否绑定微信
- (void)saveWeixin:(NSString *)wx{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"wx"];
    [settings setObject:wx forKey:@"wx"];
    [settings synchronize];
}
//绑定支付宝
- (void)saveZFB:(NSString *)zfb{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"zfb"];
    [settings setObject:zfb forKey:@"zfb"];
    [settings synchronize];
}
- (void)saveMoney:(NSString *)money{
    NSUserDefaults *setttings = [NSUserDefaults standardUserDefaults];
    [setttings removeObjectForKey:@"balance"];
    [setttings setObject:money forKey:@"balance"];
}
- (NSString *)getmemId{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"memid"];
}

- (NSString *)getloginName{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"loginName"];
}
- (NSString *)getIsShop{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"isShop"];
}

- (NSString *)getIsAgency{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"isAgency"];
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

- (NSString *)getphoneNum{
    NSUserDefaults * settings =[NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"phone"];
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
- (NSString *)getCityCode{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"cityCode"];
}


- (NSString *)getMoney
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"balance"];
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
    if (![settings stringForKey:@"token"]) {
        return @"";
    }
    return [settings stringForKey:@"token"];
}
- (NSString *)getUserPhoneNum
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"phone"];
}
- (NSString *)getIcon
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"icon"];
}
- (NSString *)getVersion{
    NSUserDefaults *settins = [NSUserDefaults standardUserDefaults];
    return [settins stringForKey:@"version"];
}
//是否绑定微信
- (NSString *)getLinkWX{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"wx"];
}
//是否绑定支付宝
- (NSString *)getZFB{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings stringForKey:@"zfb"];
}
- (void)logout{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"token"];
    [settings removeObjectForKey:@"icon"];
    [settings removeObjectForKey:@"username"];
    [settings removeObjectForKey:@"isteacher"];
    [settings removeObjectForKey:@"phone"];
    
}
- (void)deleteTeminate{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"terminate"];
}

@end
