//
//  UIAlertView+flash.m
//  eShangBao
//
//  Created by Dev on 16/2/2.
//  Copyright © 2016年 doumee. All rights reserved.
//

#import "UIAlertView+flash.h"

@implementation UIAlertView (flash)

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message  buttonTitle:(NSString *)buttonTitle
{
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    [alertView show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1), dispatch_get_current_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });

    
    
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message UIViewController:(UIViewController*)controller
{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1), dispatch_get_current_queue(), ^{
        //        [alert dismissViewControllerAnimated:YES completion:^{
        //            [alert removeFromParentViewController];
        //            [controller.view endEditing:YES];
        ////            [controller.navigationController popViewControllerAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1), dispatch_get_current_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [controller.view endEditing:YES];
            [controller.navigationController popViewControllerAnimated:YES];
        });
        //        }];
    });

    
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message UIViewController:(UIViewController *)controller UITextField:(UITextField *)textFiled
{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    [controller presentViewController:alert animated:YES completion:nil];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1), dispatch_get_current_queue(), ^{
//        [alert dismissViewControllerAnimated:YES completion:^{
//            [alert removeFromParentViewController];
//            [controller.view endEditing:YES];
////            [controller.navigationController popViewControllerAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1), dispatch_get_current_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [textFiled endEditing:YES];
//            [controller.view endEditing:YES];
//            [controller.view endEditing:YES];
        });
//        }];
//    });
}
@end
