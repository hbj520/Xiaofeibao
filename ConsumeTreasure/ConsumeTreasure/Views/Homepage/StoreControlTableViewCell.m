//
//  StoreControlTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreControlTableViewCell.h"

@implementation StoreControlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)piker:(id)sender {
    
    if (self.pikerBlock) {
        self.pikerBlock();
    }
    
}

@end
