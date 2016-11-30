//
//  OtherLicenseTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OtherLicenseTableViewCell.h"

@implementation OtherLicenseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)otherClick:(id)sender {
    if (self.otherBlock) {
        self.otherBlock();
    }
}

@end
