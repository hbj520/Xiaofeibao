//
//  SYQMoneyTableViewCell.m
//  eShangBao
//
//  Created by Dev on 16/6/29.
//  Copyright © 2016年 doumee. All rights reserved.
//

#import "SYQMoneyTableViewCell.h"

@implementation SYQMoneyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    
}

- (IBAction)applyBuy:(id)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
}

- (IBAction)reduce:(id)sender {
    if (self.reduceBlock) {
        self.reduceBlock();
    }
}

- (IBAction)plus:(id)sender {
    if (self.plusBlock) {
        self.plusBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
