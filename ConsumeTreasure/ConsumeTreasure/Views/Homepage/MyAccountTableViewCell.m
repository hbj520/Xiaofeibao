//
//  MyAccountTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyAccountTableViewCell.h"

@implementation MyAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self creatGesture];
}

- (void)creatGesture{
    UITapGestureRecognizer *tapSpread = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spreadClick:)];
    [self.spreadView addGestureRecognizer:tapSpread];
    UITapGestureRecognizer *tapCommishion = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commissionClick:)];
    [self.partnerCommissionView addGestureRecognizer:tapCommishion];
    UITapGestureRecognizer *tapPay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payClick:)];
    [self.payBackView addGestureRecognizer:tapPay];
    UITapGestureRecognizer *tapBenefit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(benefitClick:)];
}

- (void)spreadClick:(id)Ges{
    if (self.spreadBlock) {
        self.spreadBlock();
    }
}
- (void)commissionClick:(id)Ges{
    if (self.CommissionBlock) {
        self.CommissionBlock();
    }
}
- (void)payClick:(id)Ges{
    if (self.payBackBlock) {
        self.payBackBlock();
    }
}
- (void)benefitClick:(id)Ges{
    if (self.BenefitBlock) {
        self.BenefitBlock();
    }
}
- (IBAction)applyMoney:(id)sender {
    if (self.applyBtnBlock) {
        self.applyBtnBlock();
    }
}
- (IBAction)back:(id)sender {
    if (self.backBtnBlock) {
        self.backBtnBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
