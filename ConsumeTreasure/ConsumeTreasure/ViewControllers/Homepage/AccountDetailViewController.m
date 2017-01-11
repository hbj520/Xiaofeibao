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
    ShangHuIncomeModel *_shanghuModel;
    DaLiIncomeModel *_daliModel;
    
    
    NSInteger incomeType;
    
}
@end

@implementation AccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (incomeType == 1) {
        self.shopNameLab.text = self.shopNameLab2.text = _aModel.shopName;
        if ([_aModel.type isEqualToString:@"0"]) {
            self.accountChangeLab.text = [NSString stringWithFormat:@"- %@",_aModel.goldnum];
        }else{
            self.accountChangeLab.text = [NSString stringWithFormat:@"+ %@",_aModel.goldnum];
        }
        self.actionTimeLab.text = _aModel.createtime;
        self.dateLab.text = _aModel.createdate;
        self.yearLab.text = _aModel.createyear;
        self.accountDescripTextView.text = _aModel.account_description;
    }else if (incomeType == 2){
        
        self.shopNameLab.text = self.shopNameLab2.text = _aModel.shopName;
        if ([_aModel.type isEqualToString:@"0"]) {
            self.accountChangeLab.text = [NSString stringWithFormat:@"- %@",_aModel.goldnum];
        }else{
            self.accountChangeLab.text = [NSString stringWithFormat:@"+ %@",_aModel.goldnum];
        }
        self.actionTimeLab.text = _aModel.createtime;
        self.dateLab.text = _aModel.createdate;
        self.accountDescripTextView.text = _aModel.account_description;
    }else{
        self.shopNameLab.text = self.shopNameLab2.text = _aModel.shopName;
        if ([_aModel.type isEqualToString:@"0"]) {
            self.accountChangeLab.text = [NSString stringWithFormat:@"- %@",_aModel.goldnum];
        }else{
            self.accountChangeLab.text = [NSString stringWithFormat:@"+ %@",_aModel.goldnum];
        }
        self.actionTimeLab.text = _aModel.createtime;
        self.dateLab.text = _aModel.createdate;
        self.accountDescripTextView.text = _aModel.account_description;
    }
}
 

- (void)setModel:(AccountModel *)model{
    
    NSLog(@"😝%@😉",model);
    _aModel = model;
    incomeType = 1;
}

- (void)setShanghuModel:(ShangHuIncomeModel *)shanghuModel{
    _shanghuModel = shanghuModel;
    incomeType = 2;
}

- (void)setDaliModel:(DaLiIncomeModel *)daliModel{
    _daliModel = daliModel;
    incomeType = 3;
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
