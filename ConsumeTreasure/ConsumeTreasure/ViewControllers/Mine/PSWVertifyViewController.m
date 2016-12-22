//
//  PSWVertifyViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PSWVertifyViewController.h"

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
    NSDictionary *para = @{
                           @"phone":[[XFBConfig Instance]getUserName],
                           @"type":@"1"
                           };
    [[MyAPI sharedAPI] postVerifyCodeWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            showAlert(@"验证码发送成功，请稍等");
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)post:(id)sender {
    NSDictionary *para = @{
                           @"phone":[[XFBConfig Instance]getUserName],
                           @"repassword":self.savePsw,
                           @"validatecode":self.vertifyText.text,
                           @"type":@"2"
                           };
    [[MyAPI sharedAPI] postPayPswWithParameters:para result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            showAlert(@"设置成功");
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
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
