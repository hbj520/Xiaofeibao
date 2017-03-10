

//
//  AppDelegate.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginAndRegisterViewController.h"
#import "CHSocialService.h"
#import "UMSocialConfig.h"
#import "UMSocialControllerService.h"
#import<AlipaySDK/AlipaySDK.h>

#import <AFNetworking.h>
#import <CrashMaster/CrashMaster.h>
#import <CrashMaster/CrashMasterConfig.h>
// 极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
#endif


static NSString * const JPUSHAPPKEY = @"d405d2a2e20ec28537f2d63a"; // 极光appKey
static NSString * const channel = @"channel"; // 固定的

#ifdef DEBUG // 开发

static BOOL const isProduction = FALSE; // 极光FALSE为开发环境

#else // 生产

static BOOL const isProduction = TRUE; // 极光TRUE为生产环境

#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
  //  [WXApi registerApp:@"wxbbcf236b07638282"];
    
    self.cityCode = @"127";
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"PZH6FREFAwAbtUizlhYrAxXS6XOG3DDQ"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
     [self changeToMain];
    
    //友盟
    //设置友盟appkey
    [self configThirdLogin];
    
    
    // 注册apns通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }
    else // iOS7
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    /*
     *  launchingOption 启动参数.
     *  appKey 一个JPush 应用必须的,唯一的标识.
     *  channel 发布渠道. 可选.
     *  isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
     *  advertisingIdentifier 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
     * 此接口必须在 App 启动时调用, 否则 JPush SDK 将无法正常工作.
     */
    // 广告标识符
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 如不需要使用IDFA，advertisingIdentifier 可为nil
    // 注册极光推送
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHAPPKEY channel:channel apsForProduction:isProduction advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0)
        {
            // iOS10获取registrationID放到这里了, 可以存到缓存里, 用来标识用户单独发送推送
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    //测试
    [CrashMaster init:@"4067ca4fc934ddc0757d1eacf96b505b" channel:@"AppStore" config:[CrashMasterConfig defaultConfig]];
    return YES;
   
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//----------------------------------------------------------------------

#pragma mark - iOS7: 收到推送消息调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // iOS7之后调用这个
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知");
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0)
    {
        // 程序在前台或通过点击推送进来的会弹这个alert
        NSString *message = [NSString stringWithFormat:@"iOS7-8-9收到的推送%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil, nil];
        [alert show];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

//----------------------------------------------------------------------
#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"will%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        NSLog(@"iOS10程序在前台时收到的推送: %@", message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil, nil];
        [alert show];
    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        NSLog(@"iOS10程序关闭后通过点击推送进入程序弹出的通知: %@", message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ,nil];
        [alert show];
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [CHSocialServiceCenter  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if (self.iszfbLink) {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //linkzfbNotice
            
            if (self.isLinkVc) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"linkzfbNotice" object:nil userInfo:resultDic];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"zfbNotification" object:nil userInfo:resultDic];
            }
            
        }];
    }
   
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSString *resultStatusStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            int resultStatus = resultStatusStr.intValue;
            NSLog(@"reslut = %d",resultStatus);
            
            
            if (resultStatus == 9000) {
                
                showAlert(@"成功");
                
            }else{
                
                showAlert(@"失败");
            }
        }];
    }
    
    return [CHSocialServiceCenter handleOpenURL:url delegate:nil];
    
    
    
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            
//            NSString *resultStatusStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
//            int resultStatus = resultStatusStr.intValue;
//            NSLog(@"reslut = %d",resultStatus);
//            
//            
//            if (resultStatus == 9000) {
//                
//                showAlert(@"成功");
//                
//            }else{
//                
//                showAlert(@"失败");
//            }
//        }];
//    }
//    return [CHSocialServiceCenter handleOpenURL:url delegate:nil];
//}




#pragma mark - PrivateMethod
- (void)changeToMain{

    self.latitude = @"31.4450";
    self.longitude = @"117.1650";
    self.cityCode = @"127";
        self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homVC];
        homVC.navigationController.navigationBarHidden = YES;


    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.window endEditing:YES];
}

#pragma mark -WeixinDelegate
- (void)configThirdLogin{
    [CHSocialServiceCenter setUmengAppkey:@"588085dbc8957617840015a3"];
  
    [[CHSocialServiceCenter shareInstance] configurationAppKey:nil AppIdentifier:@"wxbbcf236b07638282" secret:@"dfdec49a41e45c6dbbdbfaa215da1454" redirectURL:nil sourceURL:@"http://www.baidu.com" type:CHSocialWeChat];
  
}

- (void)onResp:(BaseResp *)resp{
    
    
    
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
}

 
 
@end
