//
//  BusinessTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BusinessTableViewCell.h"

@implementation BusinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)licenseClick:(id)sender {
    if (self.licenseBlock) {
        self.licenseBlock();
    }
}

@end
