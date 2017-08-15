//
//  StoreConLabTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreConLabTableViewCell.h"

@implementation StoreConLabTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)click:(id)sender {
    if (self.pikerBlock) {
        self.pikerBlock();
    }
    
    if (self.cateBlock) {
        self.cateBlock();
    }
    if (self.contactBlock) {
        self.contactBlock();
    }
    if (self.addrBlock) {
        self.addrBlock();
    }
    if (self.licenseBlock) {
        self.licenseBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
