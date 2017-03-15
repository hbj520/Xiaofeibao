//
//  ModifyPwdViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/26.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "UIViewController+HUD.h"
#import "Config.h"
#import "Tools.h"
@interface ModifyPwdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldpassword;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *comfirmpassword;

@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commitBtn.layer.cornerRadius = 6;
    self.commitBtn.layer.masksToBounds = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//修改密码
- (IBAction)reviseAction:(id)sender {
    
    [Tools hideKeyBoard];
    
    if(self.oldpassword.text.length == 0 || self.newpassword.text.length == 0 || self.comfirmpassword.text.length == 0){
        [self showHint:@"输入不能为空"];
        return;
    }
    
    if(!(self.newpassword.text.length >= 6 && self.newpassword.text.length <= 20))
    {
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if(!(self.comfirmpassword.text.length >= 6 && self.comfirmpassword.text.length <= 20)){
        [self showHint:@"密码长度不符合要求"];
        return;
    }
    if([self.newpassword.text isEqualToString:self.comfirmpassword.text]){
        [self showHudInView:self.view hint:@"修改中"];
        NSString * oldSecurityString = [Tools loginPasswordSecurityLock:self.oldpassword.text];
        NSLog(@"%@",oldSecurityString);
        NSString * newSecurityString = [Tools loginPasswordSecurityLock:self.newpassword.text];
        
    }else{
        [self showHint:@"两次密码输入不一样"];
    }
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //self.navigationController.navigationBarHidden = YES;
}
- (void)RebuildlogOut{
    if (KToken) {
      //  [[Config Instance] logout];
    }
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *mineVC = [storybord instantiateViewControllerWithIdentifier:@"MineStoryBordId"];
    mineVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController popViewControllerAnimated:YES];
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

@end
