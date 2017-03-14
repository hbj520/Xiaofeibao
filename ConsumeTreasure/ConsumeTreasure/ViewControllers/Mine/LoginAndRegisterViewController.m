

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
#import "WXApi.h"
#import "AppDelegate.h"
#import "CHSocialService.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "ThirdPlatformViewController.h"

#import "JPUSHService.h"
@interface LoginAndRegisterViewController ()<UINavigationControllerDelegate>
{
    NSTimer *timer;
    NSInteger time;
    UIButton *circleSelectBtn;
    
    
    AppDelegate *appdelegate;
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
    //监听支付宝收到通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveZfbNoticeAct:) name:@"zfbNotification" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self verifyThirdPlatform];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"zfbNotification" object:nil];
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
- (void)recieveZfbNoticeAct:(NSNotification *)userInfo{
    NSString *auth_code = userInfo.userInfo[@"auth_code"];
    if (auth_code) {
        [self thirdLoginWithPlatform:@"zfb" openId:auth_code nickName:@"" iconUrl:@""];
    }
}
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
    [[MyAPI sharedAPI] loginWithParameters:para result:^(BOOL sucess, NSString *msg, NSArray *array) {
                                                 
                                                 if (sucess) {
                                                     
                                                     if ([array[0] isEqualToString:@"1"]) {

                                                         [self.view removeFromSuperview];
                                                         [self removeFromParentViewController];
                                                         [Tools chooseRootController];
                                                     }else{
                                                         [self changeTohom];
                                                     }
                                                    
                                                     [[XFBConfig Instance] savePhoneNum:self.loginPhoneNumTextField.text];
                                                     [self setAlias];
                                                     
                                                 }else{
                                                     [self showHint:@"您输入的账号或密码有误"];
                                                 }
                                                 
                                             } errorResult:^(NSError *enginerError) {
                                                 [self showHint:@"登录出错"];
                                             }];
    [self hideHud];
}

- (void)changeTohom{
    //[self.tabBarController setSelectedIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    HomepageViewController *homVC = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
//    [self.navigationController didAnimateFirstHalfOfRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
//    [self.navigationController pushViewController:homVC animated:YES];
}


- (IBAction)accountRegisterBtn:(id)sender {
    [Tools hideKeyBoard];
    if ( self.registerPhoneTextField.text.length >= 11 && self.registerPasswordTextfield.text.length >= 6 ) {
        
        NSString *securityString = [Tools loginPasswordSecurityLock:self.registerPasswordTextfield.text];
      
        
        [[MyAPI sharedAPI] registerUserWithParameters:@{
                                                        @"phone":self.registerPhoneTextField.text,
                                                        @"password":@"",
                                                        @"validatecode":self.registerVerifyCodeTextfield.text,
                                                        @"invitecode":self.registerInviteCodeTextfileld.text
                                                        } result:^(BOOL sucess, NSString *msg, NSArray *array) {
                                                            
                                                            if (sucess) {
                                                                
                                                                if ([array[0] isEqualToString:@"1"]) {
                                                                    
                                                                    [self.view removeFromSuperview];
                                                                    [self removeFromParentViewController];
                                                                    [Tools chooseRootController];
                                                                }else{
                                                                    [self changeTohom];
                                                                }
                                                                
                                                                [[XFBConfig Instance] savePhoneNum:self.registerPhoneTextField.text];
                                                                [self setAlias];
                                                                
                                                            }else{
                                                                [self showHint:@"您输入的账号或密码有误"];
                                                            }
                                                            
                                                        } errorResult:^(NSError *enginerError) {
                                                            [self showHint:@"登录出错"];
                                                        }];

    }else{
        [self showHint:@"请填写正确的账号，验证码，密码"];
    }
}


- (void)setAlias{
    //[JPUSHService registrationID];
    // NSLog(@"registrationID:%@",[JPUSHService registrationID]);
    
    NSString *alias = self.loginPhoneNumTextField.text;
    [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode,NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \n tags: %@, \n alias: %@\n", iResCode, iTags , iAlias);//对应的状态码返回为0，代表成功
    }];
}

- (IBAction)forgetPassword:(id)sender {
    //self.navigationController.navigationBarHidden = NO;
//    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
    [self performSegueWithIdentifier:@"forgetPasswordSegue" sender:nil];
}
- (void)verifyThirdPlatform{
  
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        self.wxLogin.hidden = NO;
        self.wxLoginLabel.hidden = NO;
        self.thirdLoginLabel.hidden = NO;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]])
    {
        self.zfbLoginBtn.hidden = NO;
        self.zfbLoginLabel.hidden = NO;
      //  self.thirdLoginLabel.hidden = NO;
    }

    
}


- (IBAction)wxLogin:(id)sender {
    ApplicationDelegate.iszfbLink = NO;
    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^
     (CHSocialResponseData *response) {
         if (response.unionId) {
             [self thirdLoginWithPlatform:@"wx"
                                   openId:response.unionId
                                 nickName:response.userName
                                  iconUrl:response.iconURL];
            
        }
        
    }];
   
 

    
    
    /*
    if ([WXApi isWXAppInstalled]){
        
        SendAuthReq *req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.openID = @"wxbbcf236b07638282";
        req.state = @"App";
        
        
        [WXApi sendReq:req];

        
    }else{
        //self.wxLogin.hidden = YES;

    }
    */
    
    
}

- (IBAction)zfbLoginBtn:(id)sender {
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
  //  NSString *pid = @"2088121834499540";
 //   NSString *appID = @"2016122904717216";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
 //   NSString *rsa2PrivateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCWtsCKstTac4/KyXRAsqCJvJlqffkJJpZ1bI4zDfQ9eK0JJ+B+4ugWCdyK0RWveoY65xkDlvWS1X2nAPvHRtNAofNFJSJxQzcyWSzDGWT7sQixvslcxXgSzzp/3ez+rdUD+kJ4+uoQ3Xx5Dx+TpHZ73OYIeOMzrbZppkEGgMiNCH+ESCvNqGsf2v4yFqer/RzO4DPNg0BnwuUctnPbEaOEietNSqsLpvwv2M8FM99NpDFq+bXXPtrF/CXKTMo+i7W/VgLOePxFP4/2+AfY6bEQZhu9CJUueaNEzeWsWDn5Y1vVATlY3qO5oINGV1myJSWbQf2EpbNQpRf9jhpVEFQ7AgMBAAECggEAIuNtUO4y7drgh335Bl0TYq8hCJDezGp9W/NkO5dYWb6Mt9jeVCEsvqVLw2rBTVzco9gJZ1ZTxMjdDILixe+0SXrz+KavAW8g4OvZu9QuF0GVFKhorqwbrqcAEMeL7CzLad9N8fmLo5nSDagdlCz3LJcnPQDW/4iP+Ib++IVpZ5QbZ3IZIQW/l606aPczUddzFd/NvagLMykBClfAFfYJUd6mSdhn4XWrbXk80nrGR8lDG4jZHizffp/Bg5X0P6fLEa7HZ/md0GzzsuY6jjJrW/HtrYg7OPgym4fg2vOK32NRzTgawfIjboqtZMzbRl/DynlASoOgSnAm4pOIGeKy4QKBgQDeIqdUmUqLf+UVqidkyLB5PrYhpnX0V8jeSvMRuKgX/sbjcod4D5oU7p4EFnUwwgcDRqieWOj6FEq1XIwhgFr+iQTlsYGx4+WIqSvJHb7CM3WFKyoLaNdpSgLZGPWBxUei64yyIdgexMD/QEFQ8Mna+5r43tbaDQADCr7r9+o1CwKBgQCtsLWrs1kN0csdF1bHwWLLzYm84QKm4F7uexVeSr1jf414D26uL6SJppDDJDWdrbDf1Og0/UftoNktApfGiFxOf8XzKvRTAJkv2vgtlGQYA2iJfATDOcFq1djc11k9OY4xwa8du5vMx2lyhF59va1mKJHcm+Mm2ecsSkumwUR7kQKBgDIHS/hZrdhNLaL7d3PTXytvXEWn39jwDGVELApJtFHzJ4gCO1Bm8yTTuPLiu/IHQN0UBNXk4FOyTkEaXtUMu3GoGlpA6BzQXtmwgBQDhvrl7AnZ9tYq/pjP+mQ6otBfRgsDUeSsiqgjV/Qk3JEGKfAPyo9SYMErPF1zBhzO8QiRAoGAIexhjyd4PTq8cPIeAOXEZgm+3SUVX4JzCCECC2iNlOFUwB5Df8HOYRQnMfXggutpoE31DGRrp/3CbQgUnLIFVU+fWd8J2SxEvxQFZOGWqxn/UNroEzk0jak2setdgpe7LfymNyhtRZGtBrDTw7tIIqvJ0UyhEPV+MShRnkAhIAECgYBMvgM+PABuFcQZXx2zx9SGKW7qHYGom9ammhx+zLAff+8PZ9GsvbxOKUAK1f+8X+eGt8ql4uDPTcxPhu+nat1XF6cvmsKFzzGBgjip0L17PxvHWvulfPqYv2Oqf9brGYQAmqtFJOlQBcbKr76njbl19OGiQWtlQNB0azXDrIX5KA==";
//    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
  //  if ([pid length] == 0 ||
   //     [appID length] == 0 ||
   //     ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
 //   {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少pid或者appID或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    //生成 auth info 对象
//    APAuthV2Info *authInfo = [APAuthV2Info new];
//    authInfo.pid = pid;
//    authInfo.appID = appID;
//    
//    //auth type
//    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
//    if (authType) {
//        authInfo.authType = authType;
//    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"AliJustPay";
    
    // 将授权信息拼接成字符串
//    NSString *authInfoStr = [authInfo description];
//    NSLog(@"authInfoStr = %@",authInfoStr);
//    
//    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    NSString *signedString = nil;
//    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//    if ((rsa2PrivateKey.length > 1)) {
//        signedString = [signer signString:authInfoStr withRSA2:YES];
//        
//    } else {
//        signedString = [signer signString:authInfoStr withRSA2:NO];
//    }
//    
//    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
//    if (signedString.length > 0) {
//        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@", authInfoStr, signedString];
     ApplicationDelegate.isLinkVc = NO;
    ApplicationDelegate.iszfbLink = YES;
       [[MyAPI sharedAPI] getZfbInfoWithResult:^(BOOL sucess, NSString *msg) {
           if (sucess) {
               [[AlipaySDK defaultService] auth_V2WithInfo:msg fromScheme:@"AliJustPay" callback:^(NSDictionary *resultDic) {
                   
               }];
           }else{
               [self showHint:msg];
           }
       } errorResult:^(NSError *enginerError) {
           [self showHint:@"支付宝参数请求出错"];
       }];

   
}
- (void)thirdLoginWithPlatform:(NSString *)platform
                        openId:(NSString *)openId
                      nickName:(NSString *)nickName
                       iconUrl:(NSString *)iconUrl {
    [[MyAPI sharedAPI] ThirdPlatformLoginWithParamters:platform
                                           thirdOpenId:openId
                                                result:^(BOOL success, NSString *msg, id object) {
                                                    
                                                    if (success) {
                                                        //已经绑定的直接登录
                                                        [self showHint:@"登录成功!"];
                                                        [self changeTohom];
                                                    }else{
                                                        //未绑定的进行账号绑定
                                                        [self performSegueWithIdentifier:@"thirdplatformSegue" sender:@[platform,openId,nickName,iconUrl]];
                                                    }
                                                } errorResult:^(NSError *enginerError) {
                                                    
                                                    
                                                }];
}
#pragma mark - PerformSegueDelegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"thirdplatformSegue"]) {
        ThirdPlatformViewController *thirdPlatformVC = segue.destinationViewController;
        thirdPlatformVC.thirdPlatformData = (NSArray *)sender;
    }
}
#pragma mark - UIViewDelegete
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Tools hideKeyBoard];
    
}
@end
