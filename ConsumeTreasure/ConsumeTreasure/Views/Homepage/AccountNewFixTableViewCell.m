//
//  AccountNewFixTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/5/16.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "AccountNewFixTableViewCell.h"

@implementation AccountNewFixTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setAccountModel:(AccountModel *)accountModel{
    if (accountModel) {
        
        self.payWayType.text = accountModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"余额:%.2f",accountModel.after_goldnum.doubleValue];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",accountModel.createyear,accountModel.createdate];
        if ([accountModel.type isEqualToString:@"0"]) {
                    self.moneyNum.text = [NSString stringWithFormat:@"-%.2f",accountModel.goldnum.doubleValue];
        }else{
                    self.moneyNum.text = [NSString stringWithFormat:@"+%.2f",accountModel.goldnum.doubleValue];
        }

        
    }
}

- (void)setShanghuModel:(ShangHuIncomeModel *)shanghuModel{
    if (shanghuModel) {
        
        self.payWayType.text = shanghuModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"%.2f",shanghuModel.after_money];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",shanghuModel.createyear,shanghuModel.createdate];
        
        if ([shanghuModel.type isEqualToString:@"0"]) {
            self.moneyNum.text = [NSString stringWithFormat:@"-%.2f",shanghuModel.money];
        }else{
            self.moneyNum.text = [NSString stringWithFormat:@"+%.2f",shanghuModel.money];}
    }
    
}
- (void)setInvestModel:(InvestIncomeModel *)investModel{
    if (investModel) {
        self.payWayType.text = investModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"%@",investModel.after_money];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",investModel.createyear,investModel.createdate];
        self.moneyNum.text = [NSString stringWithFormat:@"%@",investModel.money];
    }
}
-(void)setDaliModel:(DaLiIncomeModel *)daliModel{
    if (daliModel) {
        self.payWayType.text = daliModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"%.2f",daliModel.after_money];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",daliModel.createyear,daliModel.createdate];
        if ([daliModel.type isEqualToString:@"0"]) {
                   self.moneyNum.text = [NSString stringWithFormat:@"-%.2f",daliModel.money];
    }else{
               self.moneyNum.text = [NSString stringWithFormat:@"+%.2f",daliModel.money];    }
    }
 
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
