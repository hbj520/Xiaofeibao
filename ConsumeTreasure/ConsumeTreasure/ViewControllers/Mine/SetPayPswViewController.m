//
//  SetPayPswViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "SetPayPswViewController.h"
#import "TXTradePasswordView.h"
@interface SetPayPswViewController ()<TXTradePasswordViewDelegate>
{
    TXTradePasswordView *TXView;
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
    [self.navigationController setNavigationBarHidden:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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

#pragma mark  密码输入结束后调用此方法
-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    
    //[TXView.TF resignFirstResponder];
    NSLog(@"密码 = %@",Password);
    //[self showMessage:[NSString stringWithFormat:@"密码为 : %@",Password] duration:3];
    
    
    
    
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
