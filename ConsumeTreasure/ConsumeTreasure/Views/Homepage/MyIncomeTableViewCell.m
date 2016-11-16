//
//  MyIncomeTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyIncomeTableViewCell.h"

@implementation MyIncomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
