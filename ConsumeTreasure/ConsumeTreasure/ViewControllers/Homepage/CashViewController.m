//
//  CashViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "CashViewController.h"

@interface CashViewController ()

@end

@implementation CashViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
  
}

- (void)setIncomeMoney:(NSArray *)incomeMoney{
    
    if (incomeMoney.count > 0) {
        self.dayIncome.text = incomeMoney[0];
        NSString *str = incomeMoney[0];
        self.allIncome.text = incomeMoney[1];
    }
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)GetMoneyRecordClick:(id)sender {
    //提现记录
}
- (IBAction)getMoneyNow:(id)sender {
    [self performSegueWithIdentifier:@"goWithdrawSegue" sender:nil];
    
}
- (IBAction)getHistoryMoney:(id)sender {
    [self performSegueWithIdentifier:@"goWithdrawSegue" sender:nil];
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
