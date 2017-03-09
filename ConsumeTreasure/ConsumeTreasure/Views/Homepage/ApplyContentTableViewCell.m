//
//  ApplyContentTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ApplyContentTableViewCell.h"

@implementation ApplyContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)choose:(id)sender {
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

- (IBAction)position:(id)sender {
    if (self.positionBlock) {
        self.positionBlock();
    }
}


@end
