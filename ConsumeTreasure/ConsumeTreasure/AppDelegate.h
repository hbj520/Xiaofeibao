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
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,WXApiDelegate>
{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIStoryboard *mStorybord;
@property (strong,nonatomic) UINavigationController *navVC;
@property (strong,nonatomic) NSString *latitude;//精度
@property (strong,nonatomic) NSString *longitude;//维度
@property (strong,nonatomic) NSString *cityCode;//维度
- (void)changeToMain;
@end

