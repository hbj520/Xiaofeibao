//
//  AccountDetailViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AccountDetailViewController.h"

@interface AccountDetailViewController ()
{
    AccountModel *_aModel;
}
@end

@implementation AccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shopNameLab.text = self.shopNameLab2.text = _aModel.shopName;
    if ([_aModel.type isEqualToString:@"0"]) {
        self.accountChangeLab.text = [NSString stringWithFormat:@"- %@",_aModel.goldnum];
    }else{
        self.accountChangeLab.text = [NSString stringWithFormat:@"+ %@",_aModel.goldnum];
    }
    self.actionTimeLab.text = [Tools dealtimeStr:_aModel.createdate];
    self.accountDescripTextView.text = _aModel.account_description;
}

- (void)setModel:(AccountModel *)model{
    
    NSLog(@"😝%@😉",model);
    _aModel = model;
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
