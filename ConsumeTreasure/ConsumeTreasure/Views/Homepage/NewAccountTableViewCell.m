//
//  NewAccountTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/1/6.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "NewAccountTableViewCell.h"

@implementation NewAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAccountModel:(AccountModel *)accountModel{
    if (accountModel) {
        
        self.dayTimeStr.text = accountModel.createdate;
        self.detailTimeStr.text = accountModel.createtime;
        
        if ([accountModel.type isEqualToString:@"0"]) {
            self.shouzhiImage.image = [UIImage imageNamed:@"zhi"];
            self.moneyStr.text = [NSString stringWithFormat:@"- %@",accountModel.goldnum];
        }else{
            self.shouzhiImage.image = [UIImage imageNamed:@"shou"];
            self.moneyStr.text = [NSString stringWithFormat:@"+ %@",accountModel.goldnum];
        }
    }
}

- (void)setShanghuModel:(ShangHuIncomeModel *)shanghuModel{
    if (shanghuModel) {
        
        self.dayTimeStr.text = shanghuModel.createdate;
        self.detailTimeStr.text = shanghuModel.createtime;
        
        if ([shanghuModel.type isEqualToString:@"0"]) {
            self.shouzhiImage.image = [UIImage imageNamed:@"zhi"];
            self.moneyStr.text = [NSString stringWithFormat:@"- %.2f",shanghuModel.money];
        }else{
            self.shouzhiImage.image = [UIImage imageNamed:@"shou"];
            self.moneyStr.text = [NSString stringWithFormat:@"+ %.2f",shanghuModel.money];
        }
    }

}

-(void)setDaliModel:(DaLiIncomeModel *)daliModel{
    if (daliModel) {
        
        self.dayTimeStr.text = daliModel.createdate;
        self.detailTimeStr.text = daliModel.createtime;
        
        if ([daliModel.type isEqualToString:@"0"]) {
            self.shouzhiImage.image = [UIImage imageNamed:@"zhi"];
            self.moneyStr.text = [NSString stringWithFormat:@"- %.2f",daliModel.money];
        }else{
            self.shouzhiImage.image = [UIImage imageNamed:@"shou"];
            self.moneyStr.text = [NSString stringWithFormat:@"+ %.2f",daliModel.money];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
