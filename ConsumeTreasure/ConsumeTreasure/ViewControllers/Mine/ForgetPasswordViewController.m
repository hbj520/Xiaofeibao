//
//  ForgetPasswordViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/14/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "HexColor.h"
@interface ForgetPasswordViewController ()
{
    NSTimer *timer;
    NSInteger time;
}
- (IBAction)backBtn:(id)sender;
- (IBAction)resetPassWord:(id)sender;
- (IBAction)postBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)mBackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *valueCode;
- (IBAction)voiceVerifyCodeBtn:(id)sender;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *navTitle = @"忘记密码";
   // self.navigationController.navigationBar.barTintColor = RGBACOLOR(253, 87, 54, 1);
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = attributeDict;
    self.navigationItem.title = navTitle;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationItem.hidesBackButton = YES;
    if ([[XFBConfig Instance] getphoneNum]) {
        self.tabBarController.tabBar.hidden = YES;
        self.phoneTextField.text = [[XFBConfig Instance] getphoneNum];
        self.phoneTextField.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([[XFBConfig Instance] getphoneNum]) {
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
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
#pragma mark - UIViewDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
    
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)resetBtn:(id)sender {
    NSString *securityString = [Tools loginPasswordSecurityLock:self.passwordTextField.text];
    [[MyAPI sharedAPI] forgetPasswordWithParameters:@{@"phone":self.phoneTextField.text,
                                                     @"repassword":securityString,
                                                     @"validatecode":self.valueCode.text,
                                                     @"type":@"1"} result:^(BOOL sucess, NSString *msg) {
                                                         if (sucess) {
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                             [self showHint:@"修改成功"];
                                                         }else{
                                                             [self showHint:msg];

                                                         }
                                                         
                                                     } errorResult:^(NSError *enginerError) {
                                    
                                                         
                                                     }];
}


- (IBAction)postBtn:(id)sender {
    [Tools hideKeyBoard];
    if (self.phoneTextField.text.length < 11) {
        NSLog(@"错");
        [self showHint:@"请输入正确的手机号"];
        // return;
    }else{
        [[MyAPI sharedAPI] postVerifyCodeWithParameters:@{@"phone": self.phoneTextField.text,
                                                          @"type": @"1"
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
- (void)setTimeSchedu{
    self.postBtn.enabled = NO;
    [self.postBtn setBackgroundColor:[UIColor whiteColor]];
    [self.postBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}
- (void)timeAct:(id)sender{
    if (time == 0) {
        [timer invalidate];
        self.postBtn.enabled = YES;
        [self.postBtn setBackgroundColor:[UIColor whiteColor]];
        [self.postBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [self.postBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [self.postBtn setBackgroundColor:[UIColor whiteColor]];
    }
}
- (IBAction)mBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)voiceVerifyCodeBtn:(id)sender {
    [Tools hideKeyBoard];
    if (self.phoneTextField.text.length < 11) {
        NSLog(@"错");
        [self showHint:@"请输入正确的手机号"];
        // return;
    }else{
        [[MyAPI sharedAPI] postVerifyCodeWithParameters:@{@"phone": self.phoneTextField.text,
                                                          @"type": @"-2"
                                                          } result:^(BOOL sucess, NSString *msg) {
                                                              if (sucess) {
                                                                  [self showHint:msg];
                                                              }else{
                                                                  [self showHint:msg];
                                                              }
                                                              
                                                          } errorResult:^(NSError *enginerError) {
                                                              
                                                              [self showHint:@"验证码注册出错"];
                                                          }];
    }
}
@end
