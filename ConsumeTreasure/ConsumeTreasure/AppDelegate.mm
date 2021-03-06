

//
//  AppDelegate.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//
#import "JXMapNavigationView.h"
#import "AppDelegate.h"
#import "LoginAndRegisterViewController.h"
#import "CHSocialService.h"
#import "UMSocialConfig.h"
#import "UMSocialControllerService.h"
#import<AlipaySDK/AlipaySDK.h>
#import "HomeTabbarViewController.h"
#import <AFNetworking.h>
#import <CrashMaster/CrashMaster.h>
#import <CrashMaster/CrashMasterConfig.h>

// 这里是iOS10需要用到的框架
#import "UnionIncomeViewController.h"

static NSString * const JPUSHAPPKEY = @"d405d2a2e20ec28537f2d63a"; // 极光appKey
static NSString * const channel = @"channel"; // 固定的

#ifdef DEBUG // 开发

static BOOL const isProduction = FALSE; // 极光FALSE为开发环境

#else // 生产

static BOOL const isProduction = TRUE; // 极光TRUE为生产环境

#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupBaidu];
    [self changeToMain];
    //友盟
    //设置友盟appkey
    [self configThirdLogin];
    [self setupJPSHWithOption:launchOptions];
    //无网络提示
    [self addNoNetNotice];
    //讯飞
    [self setupIFly];
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];

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

#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = userInfo[@"msg"];
         [_iFlySpeechSynthesizer startSpeaking: message];

    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
//
//// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        if ([[userInfo[@"aps"] objectForKey:@"sound"] isEqualToString:@"noticeVoice.wav"]) {
            UIStoryboard *incomeStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:[NSBundle mainBundle]];
            UnionIncomeViewController *incomeVC = [incomeStorybord instantiateViewControllerWithIdentifier:@"incomeDetailStorybordId"];
            incomeVC.title = @"收益明细";
            UIViewController *presentVc = [self currentViewController];
            [presentVc presentViewController:incomeVC animated:YES completion:^{
                
            }];
        }
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
-(void)application:(UIApplication* )application didReceiveRemoteNotification:(NSDictionary* )userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
     [JPUSHService handleRemoteNotification:userInfo];
    NSString *message = userInfo[@"msg"];
    [_iFlySpeechSynthesizer startSpeaking: message];
    completionHandler(UIBackgroundFetchResultNewData);
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [application cancelAllLocalNotifications];
    
    JXMapNavigationView *view = [[JXMapNavigationView alloc]init];
    [view remove];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [CHSocialServiceCenter  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)userNotificationCenter:(UNUserNotificationCenter* )center willPresentNotification:(UNNotification* )notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    completionHandler(UNNotificationPresentationOptionAlert);
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
   // [[IFlySpeechUtility getUtility] handleOpenURL:url];
    
    return [CHSocialServiceCenter handleOpenURL:url delegate:nil];
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}


#pragma mark - PrivateMethod
- (void)setupIFly{
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    [self InstanceIfly];
}
- (void)setupJPSHWithOption:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // 如不需要使用IDFA，advertisingIdentifier 可为nil
    // 注册极光推送
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHAPPKEY channel:channel apsForProduction:isProduction advertisingIdentifier:nil];
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
  //  [CrashMaster init:@"4067ca4fc934ddc0757d1eacf96b505b" channel:@"AppStore" config:[CrashMasterConfig defaultConfig]];
}
- (void)setupBaidu{
    self.cityCode = @"127";
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"PZH6FREFAwAbtUizlhYrAxXS6XOG3DDQ"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
- (void)InstanceIfly{
    //获取语音合成单例
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    //设置协议委托对象
    _iFlySpeechSynthesizer.delegate = self;
    //设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置音量，取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50"
                                  forKey: [IFlySpeechConstant VOLUME]];
    //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                  forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [_iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                  forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //启动合成会话
    //IFlySpeechSynthesizerDelegate协议实现
    
}
-(UIViewController *)currentViewController
{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }else if ([Rootvc isKindOfClass:[HomeTabbarViewController class]]){
            HomeTabbarViewController * tabVC = (HomeTabbarViewController *)Rootvc;
            currVC = tabVC;
            Rootvc = tabVC.selectedViewController;
            continue;
        }
    } while (Rootvc!=nil);
    
    
    return currVC;
}
- (void)addNoNetNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNoNet:) name:@"netIsNotReachabel" object:nil];
}
- (void)recieveNoNet:(NSNotification *)noti{
    showAlert(@"当前无网络，请检查网络连接");
}
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
#pragma  mark -IflyDelegate
//合成结束
- (void) onCompleted:(IFlySpeechError *) error {
    
}
//合成开始
- (void) onSpeakBegin {
    
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {
    
}
//合成播放进度
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos {
    
}

- (void)dealloc{
    [_iFlySpeechSynthesizer stopSpeaking];
    _iFlySpeechSynthesizer.delegate = nil;
  
}
 
@end
