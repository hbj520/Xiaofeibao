//
//  LoginAndRegisterViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 10/13/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "HexColor.h"

@interface LoginAndRegisterViewController ()
{
    NSTimer *timer;
    NSInteger time;
}
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
    //添加注册发送验证码按钮动作
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
- (void)timeAct:(id)sender{
     UIButton *postCodeBtn = [self.registerView viewWithTag:11];
    if (time == 0) {
        [timer invalidate];
        postCodeBtn.enabled = YES;
        [postCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"FF5000"]];
        [postCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [postCodeBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [postCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}
- (void)setTimeSchedu{
    UIButton *postCodeBtn = [self.registerView viewWithTag:11];
    postCodeBtn.enabled = NO;
    [postCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
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
        [self showHint:@"请输入正确的手机号"];
        return;
    }
    [self setTimeSchedu];
    
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
#pragma mark - UIViewDelegete
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
    
}
@end
