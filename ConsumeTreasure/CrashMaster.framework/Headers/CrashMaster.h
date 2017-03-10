//
//  FRAppAgent.h
//
//  Copyright (c) 2014 Testin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CrashMasterConfig.h"

@interface CrashMaster : NSObject

+ (void)init:(NSString*)appKey DEPRECATED_MSG_ATTRIBUTE("use init:channel:config");
+ (void)init:(NSString*)appKey channel:(NSString*)channel DEPRECATED_MSG_ATTRIBUTE("use init:channel:config");

+ (void)init:(NSString*)appKey
     channel:(NSString*)channel
      config:(CrashMasterConfig*)config;

+ (void)init:(NSString*)appKey
     groupId:(NSString*)groupId
     channel:(NSString*)channel
      config:(CrashMasterConfig*)config;

+ (void)setUserInfo:(NSString*)userInfo;

/******************当enabledShakeFeedback为NO时，以下方法无效****************/
//如果Key不存在，则添加数据，并且data不能为空.
//如果Key已存在，并且data为nil，则删除这个Key，如果data不为nil，则修改这个Key的数据.
+ (void)setUserData:(NSString*)data forKey:(NSString*)key;
//删除所有数据.
+ (void)removeAllUserData;
//开启/关闭摇一摇反馈
+ (void)enabledShakeFeedback:(BOOL)enabled;
//上传反馈信息
+ (void)feedbackWithMessage:(NSString*)message;
/******************当enabledShakeFeedback为NO时，以上方法无效****************/

+ (void)reportCustomizedException:(NSException*)exception message:(NSString*)message;
+ (void)reportCustomizedException:(NSNumber*)type
                          message:(NSString*)message
                       stackTrace:(NSString*)stackTrace;

+ (void)leaveBreadcrumbWithString:(NSString*)string;
+ (void)leaveBreadcrumbWithFormat:(NSString*)format, ...;

@end

