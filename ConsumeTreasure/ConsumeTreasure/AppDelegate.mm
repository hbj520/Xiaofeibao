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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:@"wxbbcf236b07638282"];
    
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
    return YES;
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url{
    return [WXApi handleOpenURL:url delegate:self];
}
/*
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
*/
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
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
    
    return [WXApi handleOpenURL:url delegate:self];
    
    

}

#pragma mark - PrivateMethod
- (void)changeToMain{
    /*
    self.mStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
    HomepageViewController *homeVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"homePageSB"];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    */
    self.latitude = @"31.4450";
    self.longitude = @"117.1650";
    self.cityCode = @"127";
  //  if (KToken) {
        self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homVC];
        homVC.navigationController.navigationBarHidden = YES;

//    }else{
//        self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        LoginAndRegisterViewController *loginAndRegisterVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginAndRegisterVC];
//    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.window endEditing:YES];
}

#pragma mark -WeixinDelegate
- (void)configThirdLogin{
    [CHSocialServiceCenter setUmengAppkey:@"588085dbc8957617840015a3"];
  //  [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    [[CHSocialServiceCenter shareInstance] configurationAppKey:nil AppIdentifier:@"wxbbcf236b07638282" secret:@"b170f4c7718470926acb509fb62c3529" redirectURL:nil sourceURL:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=7a9e5e98-d0c4-11e6-ad4a-6c92bf2cdbd1" type:CHSocialWeChat];
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
