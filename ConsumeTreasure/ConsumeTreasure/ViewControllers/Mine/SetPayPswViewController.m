//
//  SetPayPswViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SetPayPswViewController.h"
#import "TXTradePasswordView.h"


#import "PSWVertifyViewController.h"

@interface SetPayPswViewController ()<TXTradePasswordViewDelegate>
{
    TXTradePasswordView *TXView;
    
    NSInteger type;//判断第几次输入
    NSInteger same;
    
    NSString *psw;//保存第一次输入密码
}

@end

@implementation SetPayPswViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGBACOLOR(234, 235, 236, 1);
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [TXView.TF becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    type = 1;
    same = 1;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationItem.hidesBackButton = YES;
    [self addPassWordView];
}

- (void)addPassWordView{
    
     TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 150,SCREEN_WIDTH, 200) WithTitle:@"请输入交易密码"];
    TXView.TXTradePasswordDelegate = self;
    if (![TXView.TF becomeFirstResponder])
    {
        //成为第一响应者。弹出键盘
        [TXView.TF becomeFirstResponder];
    }
    
    
    [self.view addSubview:TXView];

}
- (IBAction)next:(id)sender {
    
    if (type == 1) {
        [TXView.TF becomeFirstResponder];
        [self setPSWHide];
        TXView.lable_title.text = @"请确认交易密码";
        self.navigationItem.title = @"确认交易密码";
        type = 2;
    }else{
        if (same == 2) {
            [self performSegueWithIdentifier:@"goPostVertifySegue" sender:psw];
        }else{
            showAlert(@"两次交易密码不一致，请重新设置");
            [TXView.TF becomeFirstResponder];
            [self setPSWHide];
            TXView.lable_title.text = @"请设置交易密码";
            self.navigationItem.title = @"设置交易密码";
            same = 1;
            type = 1;
        }
    }
}

#pragma mark  密码输入结束后调用此方法
-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
     [TXView.TF resignFirstResponder];
    if (type == 1) {
       
        psw = Password;
        NSLog(@"密码 = %@",Password);
    }else{
        if ([Password isEqualToString:psw]) {
            same = 2;
        }
    }
}

- (void)setPSWHide{
    TXView.lable_point.hidden = YES;
    TXView.lable_point2.hidden = YES;
    TXView.lable_point3.hidden = YES;
    TXView.lable_point4.hidden = YES;
    TXView.lable_point5.hidden = YES;
    TXView.lable_point6.hidden = YES;
    TXView.TF.text = @"";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    if (type == 1) {
        [self backTolastPage];
    }else{
        [TXView.TF becomeFirstResponder];

        [self setPSWHide];
        TXView.lable_title.text = @"请设置交易密码";
        self.navigationItem.title = @"设置交易密码";
        type = 1;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"goPostVertifySegue"]) {
        NSString *str = (NSString*)sender;
        PSWVertifyViewController *PSWVertiVC = segue.destinationViewController;
        PSWVertiVC.savePsw = str;
    }
    
}


@end
