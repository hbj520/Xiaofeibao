//
//  Tools.h
//  CRM
//
//  Created by ebadu on 14-9-2.
//  Copyright (c) 2014年 Razi. All rights reserved.
//工具类

#import <Foundation/Foundation.h>
#import "JDStatusBarNotification.h"

@interface Tools : NSObject

/**
 *  隐藏键盘
 */
+ (void)hideKeyBoard;

+ (NSString *)getZoneDataURL;

/**
 *  创建一个document的路径
 *
 *  @param file 文件名
 *
 *  @return 路径
 */
+ (NSString *)documentPath:(NSString *)file;
+(NSString *)countNumAndChangeformat:(NSString *)num;
//是否3.5存小屏幕
+ (BOOL) isSmallScreen;

+ (CGSize)stringToSize:(NSString *)str;
+(CGSize)stringToAttributeSize:(NSMutableAttributedString *)str;

+ (CGSize)stringToSizeProduct:(NSString *)str
                         font:(UIFont *)font
                       cgsize:(CGSize)cgsize;


//根据日期判断星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;

//计算几行
+ (NSInteger)simulateLinesWithArray:(NSInteger)arrayCout withList:(NSInteger)List;

//对登录密码加密(md5+base64)
+ (NSString *)loginPasswordSecurityLock:(NSString *)password;

+ (NSString*)loginPasswdSecurityLock:(NSString*)password;

//图片处理，按比例压缩
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

//选择控制器
+ (void)chooseRootController;

@end
