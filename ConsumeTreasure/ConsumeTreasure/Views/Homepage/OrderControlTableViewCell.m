//
//  OrderControlTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OrderControlTableViewCell.h"

@implementation OrderControlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setOrderModel:(OrderConModel *)orderModel{
    self.oneLab.text = @"订单号：";
    self.twoLab.text = @"订单金额：";
    self.orderNumLab.text = orderModel.pay_number;
    self.moneyLab.text = orderModel.total_money;
    self.timeLabel.text = orderModel.createDate;
}

- (void)setDaliIncomeModel:(DaLiIncomeModel *)daliIncomeModel{
    self.oneLab.text = @"收益时间：";
    self.twoLab.text = @"收益金额：";
    self.orderNumLab.text = daliIncomeModel.createdate;
    self.moneyLab.text = [NSString stringWithFormat:@"%.3f",daliIncomeModel.money];
}

- (void)setShanghuIncomeModel:(ShangHuIncomeModel *)shanghuIncomeModel{
    self.oneLab.text = @"收益时间：";
    self.twoLab.text = @"收益金额：";
    self.orderNumLab.text = shanghuIncomeModel.createdate;
    self.moneyLab.text = [NSString stringWithFormat:@"%.3f",shanghuIncomeModel.money];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
