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
    InvestIncomeModel *_investModel;
    
    NSInteger incomeType;
    
}
@end

@implementation AccountDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self.navigationController setNavigationBarHidden:YES animated:YES];
   // self.navigationController.navigationBarHidden = YES;
    
    if (incomeType == 1) {
        self.shopNameLab2.text = _aModel.shopName;
        self.shopNameLab.text  = _aModel.shopName;
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
        self.shopNameLab2.text = _shanghuModel.title;
        self.shopNameLab.text = _shanghuModel.title;
        if ([_shanghuModel.type isEqualToString:@"0"]) {
            self.accountChangeLab.text = [NSString stringWithFormat:@"- %.3f",_shanghuModel.money];
        }else{
            self.accountChangeLab.text = [NSString stringWithFormat:@"+ %.3f",_shanghuModel.money];
        }
        self.actionTimeLab.text = _shanghuModel.createtime;
        self.dateLab.text = _shanghuModel.createdate;
        self.accountDescripTextView.text = _shanghuModel.shop_description;
    }else if (incomeType == 4){
        self.shopNameLab2.text = _investModel.title;
        self.shopNameLab.text = _investModel.title;
       
       self.accountChangeLab.text = [NSString stringWithFormat:@"%@",_investModel.money];
        self.actionTimeLab.text = _investModel.createtime;
        self.dateLab.text = _investModel.createdate;
        self.accountDescripTextView.text = _investModel.record_description;
    }else{
        self.shopNameLab2.text = _daliModel.title;
        self.shopNameLab.text  = _daliModel.title;
        if ([_daliModel.type isEqualToString:@"0"]) {
              self.accountChangeLab.text = [NSString stringWithFormat:@"- %.3f",_daliModel.money];
        }else{
                self.accountChangeLab.text = [NSString stringWithFormat:@"+ %.3f",_daliModel.money];
        }
        
       
        self.actionTimeLab.text = _daliModel.createtime;
        self.dateLab.text = _daliModel.createdate;
        self.accountDescripTextView.text = _daliModel.bill_description;
    }
}




- (void)setModel:(AccountModel *)model{
    
    NSLog(@"😝%@😉",model);
    _aModel = model;
    incomeType = 1;
}

- (void)setShanghuModel:(ShangHuIncomeModel *)shanghuModel{
    _shanghuModel = shanghuModel;
    self.changeStr.text = @"类型";
    incomeType = 2;
}

- (void)setDaliModel:(DaLiIncomeModel *)daliModel{
    _daliModel = daliModel;
    self.changeStr.text = @"类型";
    incomeType = 3;
}
- (void)setInvestModel:(InvestIncomeModel *)investModel{
    _investModel = investModel;
    self.changeStr.text = @"类型";
    incomeType = 4;
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
