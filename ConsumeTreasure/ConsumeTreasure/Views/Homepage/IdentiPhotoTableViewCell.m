//
//  IdentiPhotoTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "IdentiPhotoTableViewCell.h"

@implementation IdentiPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)oneClick:(id)sender {
    if (self.oneBlock) {
        self.oneBlock();
    }
}


- (IBAction)twoClick:(id)sender {
    if (self.twoBlock) {
        self.twoBlock();
    }
}

@end
