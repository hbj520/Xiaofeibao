//
//  NoticeHelper.m
//  ERVICE
//
//  Created by youyou on 16/6/25.
//  Copyright © 2016年 hbjApple. All rights reserved.
//

#import "NoticeHelper.h"
#import "AppDelegate.h"
//#import "RecieveTeachNoticeWebViewController.h"

@implementation NoticeHelper
+ (NSInteger)ISIphoneType{
    if (ScreenWidth == 320) {
        if (ScreenHeight == 480) {
            return ISIphone4;
        }else if (ScreenHeight == 568){
            return ISIphone5;
        }
    }else if (ScreenWidth == 375){
        return ISIphone6;
    }else if (ScreenWidth == 414){
        return ISIphone6P;
    }else{
        return ISNewIphone;
    }
    return -1;
}
//收到老师消息处理
////在前台
//+(void)recieveTeacherNoticeStateActive{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveTeacherNoticeStateActive" object:nil];
//    
//}
////从前台进入后台
//+(void)recieveTeacherNoticeInactiveWithUrl:(NSString *)url{
//    ApplicationDelegate.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    RecieveTeachNoticeWebViewController *vc = [ApplicationDelegate.mStorybord instantiateViewControllerWithIdentifier:@"TeacherNoticeStorybordId"];
//    vc.url = url;
//    ApplicationDelegate.window.rootViewController = vc ;
//}
////收到系统消息处理
//+(void)recieveSystemNotice{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"recieveSystemNotice" object:nil];
//}
@end
