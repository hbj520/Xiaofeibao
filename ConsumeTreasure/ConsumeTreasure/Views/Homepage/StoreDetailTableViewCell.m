//
//  StoreDetailTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreDetailTableViewCell.h"

@implementation StoreDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDeModel:(StoreDetailModel *)deModel{
    if (deModel) {
        self.storeNameLab.text = deModel.shopName;
       // self.adresssLab.text =
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
