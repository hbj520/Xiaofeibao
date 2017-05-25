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
    NSRange frontRange = NSMakeRange(0, 3);
    NSString *bankNoFront = [data.bankno substringWithRange:frontRange];
    NSRange behindRange = NSMakeRange(data.bankno.length-3, 3);
    NSString *bankNoBehind = [data.bankno substringWithRange:behindRange];
    self.bankNameAndNum.text = [NSString stringWithFormat:@"%@     %@****%@",data.bankname,bankNoFront,bankNoBehind];
    self.timeLabel.text = data.createtime;
    self.cashMonyLabel.text = data.money;
    if ([data.status isEqualToString:@"0"]) {
        self.statusLabel.text = @"待审核";
        self.statusLabel.textColor = [UIColor yellowColor];
        self.statusLabel.layer.borderColor = [UIColor yellowColor].CGColor;

    }else if ([data.status isEqualToString:@"1"])
    {
        self.statusLabel.text = @"审核通过";
        self.statusLabel.textColor = [UIColor greenColor];

        self.statusLabel.layer.borderColor = [UIColor greenColor].CGColor;
    }else if ([data.status isEqualToString:@"-1"]){
        self.statusLabel.text = @"审核未通过";
        self.statusLabel.textColor = [UIColor redColor];
        self.statusLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    self.statusLabel.layer.cornerRadius = 5;
    self.statusLabel.layer.borderWidth = 2;
    self.statusLabel.layer.masksToBounds = YES;
}
@end
