//
//  AppDelegate.m
//  ConsumeTreasure
//
//  Created by youyou on 9/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginAndRegisterViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:@"wxbbcf236b07638282"];
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"5VtRnxH5ij6OQYmXvTqAQ55KqtmCMGy2"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
     [self changeToMain];
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
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark - PrivateMethod
- (void)changeToMain{
    /*
    self.mStorybord = [UIStoryboard storyboardWithName:@"Hompage" bundle:nil];
    HomepageViewController *homeVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"homePageSB"];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    */
 
    if (KToken) {
        self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homVC];
        homVC.navigationController.navigationBarHidden = YES;

    }else{
        self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginAndRegisterViewController *loginAndRegisterVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginAndRegisterVC];
    }
    
}
#pragma mark -WeixinDelegate
- (void)onReq:(BaseReq *)req{
    
}
- (void)onResp:(BaseResp *)resp{
    
}
@end
