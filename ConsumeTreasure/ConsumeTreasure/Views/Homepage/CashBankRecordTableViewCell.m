//
//  CashBankRecordTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/25.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "CashBankRecordTableViewCell.h"
@interface CashBankRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *bankNameAndNum;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashMonyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
@implementation CashBankRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configData:(ApplyCashModel *)data{
    //NSString *bankNoFirst = [data.bankno st]
    self.bankNameAndNum.text = [NSString stringWithFormat:@"%@     %@****%@",data.bankname];
}
@end
