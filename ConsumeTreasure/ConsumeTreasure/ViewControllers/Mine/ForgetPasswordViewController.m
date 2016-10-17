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
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationItem.hidesBackButton = YES;
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

- (IBAction)resetPassWord:(id)sender {
}

- (IBAction)postBtn:(id)sender {
    [Tools hideKeyBoard];
    if (self.phoneTextField.text.length < 11) {
        NSLog(@"错");
        
        //  [UIAlertView alertWithTitle:@"温馨提示" message:@"登录名不能为空" buttonTitle:nil];
        
        [self showHint:@"请输入正确的手机号"];
        // return;
    }else{
        [self setTimeSchedu];
    }
}
- (void)setTimeSchedu{
    self.postBtn.enabled = NO;
    [self.postBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.postBtn setTitle:@"60" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeAct:) userInfo:nil repeats:YES];
    time = 60;
    [timer fire];
}
- (void)timeAct:(id)sender{
    if (time == 0) {
        [timer invalidate];
        self.postBtn.enabled = YES;
        [self.postBtn setBackgroundColor:[UIColor colorWithHexString:@"FF5000"]];
        [self.postBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        time--;
        [self.postBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        [self.postBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}
@end
