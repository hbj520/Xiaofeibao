//
//  LoginAndRegisterViewController.h
//  ConsumeTreasure
//
//  Created by youyou on 10/13/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageViewController.h"
@interface LoginAndRegisterViewController : UIViewController
@property (strong,nonatomic) UIStoryboard *mStorybord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *wxLoginLabel;

@property (weak, nonatomic) IBOutlet UIButton *wxLogin;
@property (weak, nonatomic) IBOutlet UIButton *zfbLoginBtn;

@property (weak, nonatomic) IBOutlet UILabel *zfbLoginLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdLoginLabel;

@end
