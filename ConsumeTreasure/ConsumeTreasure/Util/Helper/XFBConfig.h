//
//  XFBConfig.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/16.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFBConfig : NSObject

+ (XFBConfig *)Instance;
+ (id)allocWithZone:(struct _NSZone *)zone;

/**
 *  保存用户信息
 *
 *  @param userid   用户编号
 *  @param username 用户名
 *  @param PhoneNum 用户手机号码
 *  @param token    用户登录令牌
 *  @param icon     用户头像
 */
- (void)saveUserid:(NSString*)userid
          userName:(NSString*)username
      userPhoneNum:(NSString*)PhoneNum
             token:(NSString*)token
              icon:(NSString*)icon;


- (void)saveImgUrl:(NSString *)imgUrl
             token:(NSString *)token
         loginName:(NSString *)loginName
           balance:(NSString *)balance
            qrCode:(NSString *)qrCode
             phone:(NSString *)phone;

//保存优币值
- (void)saveUcoin:(NSString *)ucoin;

//保存是否是讲师
- (void)saveIsteacher:(NSString *)teacher;
//保存用户名
- (void)saveUsername:(NSString *)username;
- (void)saveIcon:(NSString *)icon;
- (void)saveBackImg:(NSString *)backimage;
- (void)saveUserPassword:(NSString*)password;
- (void)saveGesturePassword:(NSString *)gesturePassword;
- (void)saveTeminate;//结束进程后保存
- (void)saveOrderNum:(NSString *)ordernum;//保存订单号
- (void)saveIsWifi:(NSString *)iswifi;
- (void)savePhoneNum:(NSString *)phoneNum;
- (void)saveCityCode:(NSString *)cityCode;//保存城市citycode

- (void)saveIsShop:(NSString*)isShop;
- (void)saveIsAgency:(NSString*)isAgency;
//- (void)saveIcon:(NSString *)icon;
- (void)saveloginName:(NSString*)name;
- (void)saveVersion:(NSString *)version; //保存版本号


- (NSString *)getloginName;
- (NSString *)getIsShop;
- (NSString *)getIsAgency;

- (NSString *)getTeminate;//
- (NSString *)getUserId;       //获取用户id
- (NSString *)getphoneNum;
- (NSString *)getUserName;     //获取用户名
//- (NSString *)getUserPhoneNum; //获取用户手机号码
- (NSString *)getisteacher;    //获取是否是讲师
- (NSString *)getToken;        //获取用户登录令牌
- (NSString *)getPassword;     //获取用户密码
- (NSString *)getMoney;        //获取财富
- (NSString *)getUcoin;        //获取优币值
- (NSString *)getIntegral;     //获取积分值
- (NSString *)getBackImage;    //获取背景图片
- (NSString *)getGesturePassword;//获取手势密码
- (NSString *)getOrderNum; //获取订单号
- (NSString *)getIsWifi;//是否可在wifi下观看视频
- (NSString *)getCityCode;
- (NSString *)getIcon;
- (NSString *)getVersion;//获取版本号
- (void)logout;               //退出登录
- (void)deleteTeminate;

@end
