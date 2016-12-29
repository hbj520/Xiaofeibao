//
//  CashViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "CashViewController.h"
#import "WithDrawViewController.h"

@interface CashViewController ()
{
    //均可提现
    NSString *strday;//今日收益
    NSString *strall;//历史收益
    
}

@end

@implementation CashViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    self.dayIncome.text = strday;
    self.allIncome.text = strall;
}

- (void)setIncomeMoney:(NSArray *)incomeMoney{
    
    if (incomeMoney.count > 0) {
        
        strday = incomeMoney[0];
        strall = incomeMoney[1];
    
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
    [self performSegueWithIdentifier:@"goWithdrawSegue" sender:strday];
    
}
- (IBAction)getHistoryMoney:(id)sender {
    [self performSegueWithIdentifier:@"goWithdrawSegue" sender:strall];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goWithdrawSegue"]) {
        NSString *canWithDrawMoney = (NSString*)sender;
        WithDrawViewController *withVC = segue.destinationViewController;
        withVC.canGetMoney = canWithDrawMoney;
        
    }
    
}


@end
