//
//  TypeChooseTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/7/17.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "TypeChooseTableViewCell.h"

@implementation TypeChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)contactClick:(id)sender {
    if (self.contactBlock) {
        self.contactBlock();
    }
}

- (IBAction)addrClick:(id)sender {
    if (self.addrBlock) {
        self.addrBlock();
    }
}

- (IBAction)licenseClick:(id)sender {
    if (self.licenseBlock) {
        self.licenseBlock();
    }
}

@end
