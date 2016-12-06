//
//  AccountDetailViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AccountDetailViewController.h"

@interface AccountDetailViewController ()

@end

@implementation AccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setModel:(AccountModel *)model{
    
    NSLog(@"😝%@😉",model);
    self.shopNameLab.text = self.shopNameLab2.text = model.shopName;
    if ([model.type isEqualToString:@"0"]) {
        self.accountChangeLab.text = [NSString stringWithFormat:@"- %@",model.goldnum];
    }else{
        self.accountChangeLab.text = [NSString stringWithFormat:@"+ %@",model.goldnum];
    }
    self.actionTimeLab.text = [Tools dealtimeStr:model.createdate];
    self.accountDescripTextView.text = model.account_description;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
