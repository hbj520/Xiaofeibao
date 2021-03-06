

//
//  PSWVertifyViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PSWVertifyViewController.h"
#import "WithDrawViewController.h"
#import "GoPrePayViewController.h"

@interface PSWVertifyViewController ()
{
    //NSString *savePayPsw;
}

@end

@implementation PSWVertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self postVertify];
    
}

- (void)postVertify{
    
   // NSString *stt = [[XFBConfig Instance] getphoneNum];
    
    NSDictionary *para = @{
                           @"phone":[[XFBConfig Instance] getphoneNum],
                           @"type":@"1"
                           };
    [[MyAPI sharedAPI] postVerifyCodeWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            showAlert(msg);
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }else{
                showAlert(msg);
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)post:(id)sender {
    [self.vertifyText resignFirstResponder];
    NSDictionary *para = @{
                           @"phone":[[XFBConfig Instance] getphoneNum
                                     
                                     ],
                           @"repassword":self.savePsw,
                           @"validatecode":self.vertifyText.text,
                           @"type":@"2"
                           };
    [[MyAPI sharedAPI] postPayPswWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            showAlert(@"设置成功");
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设置成功" preferredStyle:1];
            UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"前往支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //通知重新输入密码的时候，以前输入的密码清空
              //  WithDrawViewController *prePay = [[WithDrawViewController alloc]init];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertCon addAction:goAction];
             [self presentViewController:alertCon animated:YES completion:nil];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }else{
                showAlert(msg);
            }
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.vertifyText resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
