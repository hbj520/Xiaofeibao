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
        self.leftMoney.text = [NSString stringWithFormat:@"%.3f",accountModel.after_goldnum.doubleValue];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",accountModel.createyear,accountModel.createdate];
        self.moneyNum.text = [NSString stringWithFormat:@"%.3f",accountModel.goldnum.doubleValue];
        
    }
}

- (void)setShanghuModel:(ShangHuIncomeModel *)shanghuModel{
    if (shanghuModel) {
        
        self.payWayType.text = shanghuModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"%.3f",shanghuModel.after_money];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",shanghuModel.createyear,shanghuModel.createdate];
        self.moneyNum.text = [NSString stringWithFormat:@"%.3f",shanghuModel.money];
    }
    
}

-(void)setDaliModel:(DaLiIncomeModel *)daliModel{
    if (daliModel) {
        self.payWayType.text = daliModel.title;
        self.leftMoney.text = [NSString stringWithFormat:@"%.3f",daliModel.after_money];
        self.payTime.text = [NSString stringWithFormat:@"%@-%@",daliModel.createyear,daliModel.createdate];
        self.moneyNum.text = [NSString stringWithFormat:@"%.3f",daliModel.money];    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
