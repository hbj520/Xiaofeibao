//
//  PartnerTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PartnerTableViewCell.h"

@implementation PartnerTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // [self.starView configWithStarLevel:5];
    
}



- (IBAction)phoneClick:(id)sender {
    if (self.phoneBlock) {
        self.phoneBlock();
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithModel:(id)model{
    NSNumber *level = model;
    self.starView.isClick = YES;
    [self.starView configWithStarLevel:level.floatValue];
}
@end
