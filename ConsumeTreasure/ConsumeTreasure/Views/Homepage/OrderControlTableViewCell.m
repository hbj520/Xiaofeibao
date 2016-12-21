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
    self.orderNumLab.text = orderModel.pay_number;
    self.moneyLab.text = orderModel.total_money;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
