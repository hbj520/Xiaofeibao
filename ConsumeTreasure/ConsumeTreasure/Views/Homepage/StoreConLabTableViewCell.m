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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
