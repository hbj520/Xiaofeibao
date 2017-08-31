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
//    self.moneyLab.text =  [NSString stringWithFormat:@"%@元",orderModel.total_money];
    NSString *testString = [NSString stringWithFormat:@"%@ 元",orderModel.total_money];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:testString];
    if (attributeString) {
          NSLog(@"%ld,%ld",attributeString.length-1,attributeString.length);
    }else{
        NSLog(@"error string");
    }
  
    [attributeString addAttribute:NSForegroundColorAttributeName  //文字颜色
                            value:[UIColor blackColor]
                                   range:NSMakeRange(testString.length-1, 1 )];
    
         [attributeString addAttribute:NSFontAttributeName             //文字字体
                                           value:[UIFont systemFontOfSize:15]
                                        range:NSMakeRange(testString.length-1, 1 )];
    self.moneyLab.attributedText = attributeString;
    self.desLabel.text = orderModel.order_description;
    self.timeLabel.text = orderModel.createDate;
}

- (void)setDaliIncomeModel:(DaLiIncomeModel *)daliIncomeModel{
    self.oneLab.text = @"收益时间：";
    self.twoLab.text = @"收益金额：";
    self.orderNumLab.text = daliIncomeModel.createdate;
    self.moneyLab.text = [NSString stringWithFormat:@"%.2f元",daliIncomeModel.money];
}

- (void)setShanghuIncomeModel:(ShangHuIncomeModel *)shanghuIncomeModel{
    self.oneLab.text = @"收益时间：";
    self.twoLab.text = @"收益金额：";
    self.orderNumLab.text = shanghuIncomeModel.createdate;
    self.moneyLab.text = [NSString stringWithFormat:@"%.2f元",shanghuIncomeModel.money];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
