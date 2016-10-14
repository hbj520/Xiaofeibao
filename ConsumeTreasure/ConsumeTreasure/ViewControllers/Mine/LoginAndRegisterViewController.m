//
//  LoginAndRegisterViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/13/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "LoginAndRegisterViewController.h"

@interface LoginAndRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *registerArrow;
@property (weak, nonatomic) IBOutlet UIImageView *loginArrow;
- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtn:(id)sender;

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加注册发送验证码
    [self addPostRegisterCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - PrivateMethod
- (void)addPostRegisterCode{
    [Tools hideKeyBoard];
    UITextField *phoneTextField = [self.registerView viewWithTag:0];
    if (phoneTextField.text.length < 11) {
        
    }
    
}
//注册按钮
- (IBAction)registerBtn:(id)sender {
    self.registerArrow.hidden = NO;
    self.loginArrow.hidden = YES;
    [self.view bringSubviewToFront:self.registerView];
}
//登陆按钮
- (IBAction)loginBtn:(id)sender {
    self.registerArrow.hidden = YES;
    
    self.loginArrow.hidden = NO;
    [self.view bringSubviewToFront:self.loginView];

}
#pragma mark - UIViewDelegete
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
    
}
@end
