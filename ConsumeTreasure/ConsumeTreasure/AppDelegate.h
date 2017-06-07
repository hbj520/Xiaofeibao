//
//  AppDelegate.h
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
// wq666123

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "WXApi.h"
#import <UserNotifications/UserNotifications.h>
#import "iflyMSC/IFlyMSC.h"
#import "Definition.h"
// 极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,WXApiDelegate,IFlySpeechSynthesizerDelegate,UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>
{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIStoryboard *mStorybord;
@property (strong,nonatomic) UINavigationController *navVC;
@property (strong,nonatomic) NSString *latitude;//精度
@property (strong,nonatomic) NSString *longitude;//维度
@property (strong,nonatomic) NSString *cityCode;//维度
@property (assign,nonatomic) BOOL isOne;
@property (assign,nonatomic) BOOL isLinkVc;//是否在解绑页面
@property (assign,nonatomic) BOOL iszfbLink;//是否是支付宝解绑绑定
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;


- (void)changeToMain;
@end

