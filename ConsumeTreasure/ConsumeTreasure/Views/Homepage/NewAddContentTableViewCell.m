//
//  NewAddContentTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/7/17.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "NewAddContentTableViewCell.h"

@implementation NewAddContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/*
- (IBAction)service:(UITextField *)sender {
    if (self.serviceBlock) {
        self.serviceBlock(sender.text);
    }
}
*/
- (IBAction)aliasName:(UITextField *)sender {
    if (self.aliasNameBlock) {
        self.aliasNameBlock(sender.text);
    }
}
/*
- (IBAction)email:(UITextField *)sender {
    if (self.emailBlock) {
        self.emailBlock(sender.text);
    }
}
*/
- (IBAction)shopreturnrate:(UITextField *)sender {
    if (self.shopreturnrateBlock) {
        self.shopreturnrateBlock(sender.text);
    }
}

- (IBAction)posrate:(UITextField *)sender {
    if (self.posrateBlock) {
        self.posrateBlock(sender.text);
    }
}

- (IBAction)businessLicense:(UITextField *)sender {
    if (self.businessLicenseBlock) {
        self.businessLicenseBlock(sender.text);
    }
}

- (IBAction)cardNoTF:(UITextField *)sender {
    if (self.cardNoBlock) {
        self.cardNoBlock(sender.text);
    }
}

- (IBAction)cardNameTF:(UITextField *)sender {
    if (self.cardNameBlock) {
        self.cardNameBlock(sender.text);
    }
}

- (IBAction)shopReturnClick:(id)sender {
    if (self.shopReturnBlock) {
        self.shopReturnBlock();
    }
}

- (IBAction)posClick:(id)sender {
    if (self.posBlock) {
        self.posBlock();
    }
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
