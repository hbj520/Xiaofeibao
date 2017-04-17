//
//  RecommendTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 17/4/13.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "RecommendTableViewCell.h"
@interface RecommendTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation RecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -PrivateMethod
- (void)configWithData:(RecommendPriceModel *)model{
    self.phoneNumLabel.text = model.phone;
    self.timeLabel.text = model.createdate;
    self.moneyLabel.text = model.money;
}
@end
