//
//  NoticeHelper.h
//  ERVICE
//
//  Created by youyou on 16/6/25.
//  Copyright © 2016年 hbjApple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , ISIphoneType) {
    ISIphone4,
    ISIphone5,
    ISIphone6,
    ISIphone6P,
    ISNewIphone
};
@interface NoticeHelper : NSObject
+ (NSInteger)ISIphoneType;
////收到老师消息处理
//+(void)recieveTeacherNoticeStateActive;//在前台
//+(void)recieveTeacherNoticeInactiveWithUrl:(NSString *)url;//从前台进入后台
////收到系统消息处理
//+(void)recieveSystemNotice;
@end
