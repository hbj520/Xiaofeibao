//
//  UIAlertView+flash.h
//  eShangBao
//
//  Created by Dev on 16/2/2.
//  Copyright © 2016年 doumee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (flash)

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message  buttonTitle:(NSString *)buttonTitle;

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message UIViewController:(UIViewController*)controller;

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message UIViewController:(UIViewController*)controller UITextField:(UITextField*)textFiled;
@end
