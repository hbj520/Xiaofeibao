

//
//  LoginAndRegisterViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/13/16.
//  Copyright © 2016 youyou. All rights reserved.
//
#import "UIAlertView+flash.h"
#import "LoginAndRegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "HexColor.h"
#import "NoticeHelper.h"


@interface LoginAndRegisterViewController ()<UINavigationControllerDelegate>
{
    NSTimer *timer;
    NSInteger time;
    UIButton *circleSelectBtn;
}
@property (weak, nonatomic) IBOutlet UITextField *loginPhoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPhonePassWordTextfild;
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerVerifyCodeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *registerPasswordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *registerInviteCodeTextfileld;

@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *registerArrow;
@property (weak, nonatomic) IBOutlet UIImageView *loginArrow;
- (IBAction)registerBtn:(id)sender;

//登录约束top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
- (IBAction)loginBtn:(id)sender;
//登录按钮
- (IBAction)accountLoginBtn:(id)sender;
//注册按钮
- (IBAction)accountRegisterBtn:(id)sender;
//忘记密码
- (IBAction)forgetPassword:(id)sender;

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    //添加注册发送验证码按钮动作
    [self addPostRegisterCode];
    [self addAgreeBtn];
    if ([NoticeHelper ISIphoneType] == ISIphone5) {
        self.topLayoutConstraint.constant = 31;
    }else{
        self.topLayoutConstraint.constant = 81;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
- (void)addAgreeBtn{
  circleSelectBtn =  [self.registerView viewWithTag:16];
    [circleSelectBtn addTarget:self action:@selector(circleBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
}
//同意协议btn
- (void)circleBtnAct:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"chose_on"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"chose"] forState:UIControlStateNormal];
 
    }
    
}
- (void)timeAct:(id)sender{
     UIButton *postCodeBtn = [self.registerView viewWithTag:11];
    if (time == 0) {
        [timer invalidate];
        postCodeBtn.enabled = YES;
        [postCodeBtn setBackgroundColor:[UIColor whiteColor]];
        [postCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [postCodeBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [postCodeBtn setBackgroundColor:[UIColor whiteColor]];
    }
}
- (void)setTimeSchedu{
    UIButton *postCodeBtn = [self.registerView viewWithTag:11];
    postCodeBtn.enabled = NO;
    [postCodeBtn setBackgroundColor:[UIColor whiteColor]];
    [postCodeBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}
- (void)addPostRegisterCode{
    UIButton *postCodeBtn = [self.registerView viewWithTag:11];
    [postCodeBtn addTarget:self action:@selector(postAct:) forControlEvents:UIControlEventTouchUpInside];
   
}
- (void)postAct:(id)sender{
    [Tools hideKeyBoard];
    UITextField *phoneTextField = [self.registerView viewWithTag:10];
    if (phoneTextField.text.length < 11) {
        NSLog(@"错");
        
          //  [UIAlertView alertWithTitle:@"温馨提示" message:@"登录名不能为空" buttonTitle:nil];
        
        [self showHint:@"请输入正确的手机号"];
       // return;
    }else{
        [[MyAPI sharedAPI] postVerifyCodeWithParameters:@{@"phone": self.registerPhoneTextField.text,
                                                          @"type": @"0"
                                                          } result:^(BOOL sucess, NSString *msg) {
                                                              if (sucess) {
                                                                  [self showHint:msg];
                                                              }else{
                                                                  [self showHint:msg];
                                                              }
                                                              
        } errorResult:^(NSError *enginerError) {
            
            [self showHint:@"验证码注册出错"];
        }];
    [self setTimeSchedu];
    }
}
//注册按钮
- (IBAction)registerBtn:(id)sender {
    self.registerArrow.hidden = NO;
    self.loginArrow.hidden = YES;
    [self.view bringSubviewToFront:self.registerView];
    [Tools hideKeyBoard];
}
//登陆按钮
- (IBAction)loginBtn:(id)sender {
   
    self.registerArrow.hidden = YES;
    self.loginArrow.hidden = NO;
    [self.view bringSubviewToFront:self.loginView];
 
    [Tools hideKeyBoard];
}

- (IBAction)accountLoginBtn:(id)sender {
    [Tools hideKeyBoard];
    [self showHudInView:self.view hint:@"登录..."];
    
    NSString *securityLogin = [Tools loginPasswordSecurityLock:self.loginPhonePassWordTextfild.text];
    
    NSDictionary *para = @{
                           @"phone": self.loginPhoneNumTextField.text,
                           @"password": securityLogin
                           };
    [[MyAPI sharedAPI] loginWithParameters:para result:^(BOOL sucess, NSString *msg) {
                                                 
                                                 if (sucess) {
                                                     [self changeTohom];

                                                 }else{
                                                     [self showHint:@"您输入的账号或密码有误"];
                                                 }
                                                 
                                             } errorResult:^(NSError *enginerError) {
                                                 [self showHint:@"登陆出错"];
                                             }];
    [self hideHud];
}

- (void)changeTohom{
    self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
    [self.navigationController didAnimateFirstHalfOfRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    [self.navigationController pushViewController:homVC animated:YES];
}


- (IBAction)accountRegisterBtn:(id)sender {
    [Tools hideKeyBoard];
    if (circleSelectBtn.selected && self.registerPhoneTextField.text.length >= 11 && self.registerPasswordTextfield.text.length >= 6 ) {
        
        NSString *securityString = [Tools loginPasswordSecurityLock:self.registerPasswordTextfield.text];
      
        
        [[MyAPI sharedAPI] registerUserWithParameters:@{
                                                        @"phone":self.registerPhoneTextField.text,
                                                        @"password":securityString,
                                                        @"validatecode":self.registerVerifyCodeTextfield.text,
                                                        @"invitecode":self.registerInviteCodeTextfileld.text
                                                        } result:^(BOOL sucess, NSString *msg) {
                                                            if (sucess) {
                                                                self.registerArrow.hidden = YES;
                                                                self.loginArrow.hidden = NO;
                                                                [self.view bringSubviewToFront:self.loginView];
                                                                
                                                                [Tools hideKeyBoard];
                                                                [self showHint:msg];
                                                            }else{
                                                                //[self showHint:msg];
                                                                showAlert(msg);
                                                            }
                                                            
                                                        } errorResult:^(NSError *enginerError) {
                                                            [self showHint:@"注册出错"];
                                                        }];

    }else{
        [self showHint:@"请填写正确的账号，验证码，密码"];
    }
}

- (IBAction)forgetPassword:(id)sender {
    //self.navigationController.navigationBarHidden = NO;
//    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
    [self performSegueWithIdentifier:@"forgetPasswordSegue" sender:nil];
}
#pragma mark - UIViewDelegete
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
    
}
@end
