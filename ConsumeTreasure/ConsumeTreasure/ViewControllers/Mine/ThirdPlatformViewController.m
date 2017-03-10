//
//  ThirdPlatformViewController.m
//  FUYIFinance
//
//  Created by youyou on 9/20/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "ThirdPlatformViewController.h"
#import "HexColor.h"
#import "UIViewController+HUD.h"
#import "AppDelegate.h"

@interface ThirdPlatformViewController ()
{
    NSTimer *timer;
    NSInteger time;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextfild;
@property (weak, nonatomic) IBOutlet UIButton *postCodeBtn;
- (IBAction)confirmPhoneNumBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmPhoneNumBtn;
- (IBAction)postCodeBtn:(id)sender;
@property (assign,nonatomic) BOOL isTeacher;
- (IBAction)back:(id)sender;


@end

@implementation ThirdPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postCodeBtn.layer.cornerRadius = 3;
    self.postCodeBtn.layer.masksToBounds = YES;
    self.confirmPhoneNumBtn.layer.cornerRadius = 6;
    self.confirmPhoneNumBtn.layer.masksToBounds = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
- (void)setTimeSchedu{
    self.postCodeBtn.enabled = NO;
    [self.postCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.postCodeBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}

- (void)timeAct:(id)sender{
    if (time == 0) {
        [timer invalidate];
        self.postCodeBtn.enabled = YES;
        [self.postCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"FF5000"]];
        [self.postCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [self.postCodeBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [self.postCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}
- (IBAction)confirmPhoneNumBtn:(id)sender {
    NSString *type = self.thirdPlatformData[0];
    NSString *openid = self.thirdPlatformData[1];
    NSString *iconUrl = self.thirdPlatformData[3];
    NSString *nickName = self.thirdPlatformData[2];
   [[MyAPI sharedAPI] ThirdPlatformRegisterWithParameters:self.phoneNumTextfield.text
                                               verifyCode:self.verifyCodeTextfild.text
                                                     type:type
                                                   openid:openid
                                                  iconUrl:iconUrl
                                                 nickName:nickName
                                                  resulet:^(BOOL sucess, NSString *msg) {
                                                      if (sucess) {
                                                          [self showHint:@"绑定成功!"];
                                                          [self loginSucessAct];
                                                      }else{
                                                          [self showHint:msg];
                                                      }
       
   } errorResult:^(NSError *enginerError) {
       [self showHint:@"绑定出错"];
       
   }] ;
    
}
- (IBAction)postCodeBtn:(id)sender {
    [Tools hideKeyBoard];
    if(self.phoneNumTextfield.text.length < 11){
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    [self setTimeSchedu];
    [[MyAPI sharedAPI] ThirdPlatformVerifyWithParameters:self.phoneNumTextfield.text result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:msg];
        }else{
            time = 0;
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        [self showHint:@"验证码发送出错"];
    }];
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)loginSucessAct{
    if (ApplicationDelegate.isLinkVc) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
