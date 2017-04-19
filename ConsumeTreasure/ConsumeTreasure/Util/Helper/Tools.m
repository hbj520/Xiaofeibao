//
//  Tools.m
//  CRM
//
//  Created by ebadu on 14-9-2.
//  Copyright (c) 2014年 Razi. All rights reserved.
//

#import "Tools.h"
#import "SecurityUtil.h"
#import "AppDelegate.h"
#import "GuideViewController.h"

#import "JPUSHService.h"

@implementation Tools

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

+ (void)hideKeyBoard{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow) {
        NSArray *array=[UIApplication sharedApplication].windows;
        keyWindow=[array objectAtIndex:0];
    }
    [keyWindow endEditing:YES];
    
}

+ (NSString *)documentPath:(NSString *)file{
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory= [paths objectAtIndex:0];
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:file];
    return savedImagePath;
}



+ (NSString *)getZoneDataURL
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *Json_path = [path stringByAppendingPathComponent:@"province.json"];
    
    return Json_path;
}

//是否3.5存小屏幕
+(BOOL) isSmallScreen
{
    BOOL isSmall=NO;
    CGRect rx = [ UIScreen mainScreen ].bounds;
    if(rx.size.height<=480)
        isSmall=YES;
    
    return isSmall;
}

+ (CGSize)stringToSize:(NSString *)str{
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName :font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [str boundingRectWithSize:CGSizeMake(230, 999)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:attributes
                                           context:nil].size;
    return contentSize;
}

+(CGSize)stringToAttributeSize:(NSMutableAttributedString *)str
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName :font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [str.string boundingRectWithSize:CGSizeMake(230, 999)
                                                  options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                               attributes:attributes
                                                  context:nil].size;
    return contentSize;
}

+ (CGSize)stringToSizeProduct:(NSString *)str
                         font:(UIFont *)font
                       cgsize:(CGSize)cgsize{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName :font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [str boundingRectWithSize:cgsize
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:attributes
                                           context:nil].size;
    return contentSize;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (void)showStatusBarQueryStr:(NSString *)tipStr{
    
    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
    
}
+ (void)showStatusBarSuccessStr:(NSString *)tipStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
    }
}
+ (void)showStatusBarErrorStr:(NSString *)errorStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
    }
}
//计算几行
//计算几行
+ (NSInteger)simulateLinesWithArray:(NSInteger)arrayCout withList:(NSInteger)List{
    NSInteger lines = 0;
    if (arrayCout%List == 0) {
        lines = arrayCout/List;
    }else{
        lines = arrayCout/List + 1;
    }
    return lines;
}
//对登录密码加密
+ (NSString *)loginPasswordSecurityLock:(NSString *)password{
    ;
    
    
    return     [SecurityUtil encryptMD5String:[SecurityUtil encodeBase64String:[NSString stringWithFormat:@"%@XFB@796521",[SecurityUtil encryptMD5String:password]]]];
}

//暂不用
+ (NSString *)payPasswdSecurityLock:(NSString*)password{
    return     [SecurityUtil encryptMD5String:[SecurityUtil encodeBase64String:[NSString stringWithFormat:@"%@XFB@96478YY",[SecurityUtil encryptMD5String:password]]]];

}

+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

//选择控制器
+ (void)chooseRootController
{
    //    NSString *key = @"CFBundleVersion";
    //    // 取出沙盒中存储的上次使用软件的版本号
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *lastVersion = [defaults stringForKey:key];
    //    // 获得当前软件的版本号
    //    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //    if ([currentVersion isEqualToString:lastVersion]) {
    //        [ApplicationDelegate changeToMain];
    //    } else { // 新版本
    [UIApplication sharedApplication].keyWindow.rootViewController = [[GuideViewController alloc] init];
    //        // 存储新版本
    //        [defaults setObject:currentVersion forKey:key];
    //        [defaults synchronize];
    //    }
}

+(NSString *)dealWithtimeStr:(NSString*)str{
    
    double Rtime = [str doubleValue];
    NSDate *reTime = [NSDate dateWithTimeIntervalSince1970:Rtime];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *repTime = [formatter stringFromDate:reTime];

    return repTime;
}


+(NSString *)dealtimeStr:(NSString*)str{
    
    double Rtime = [str doubleValue];
    NSDate *reTime = [NSDate dateWithTimeIntervalSince1970:Rtime];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd hh:ss"];
    NSString *repTime = [formatter stringFromDate:reTime];
    
    return repTime;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
//登录超时
+(void)logoutWithNowVC:(UIViewController *)VC{
    
    NSString *alias = @"";
    [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode,NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \n tags: %@, \n alias: %@\n", iResCode, iTags , iAlias);//对应的状态码返回为0，代表成功
    }];
    
    UIStoryboard *mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // LoginAndRegisterViewController *loginAndRegisterVC = [mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
    UINavigationController *loginVC = [mStorybord instantiateViewControllerWithIdentifier:@"LoginAndRegisterId"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // ApplicationDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginAndRegisterVC];
    [VC.navigationController presentModalViewController:loginVC animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotice" object:nil];
    [[XFBConfig Instance] logout];

}

@end
