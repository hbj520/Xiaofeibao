//
//  HotStoreTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HotStoreTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HotStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStoreModel:(HomeStoreModel *)storeModel{
    self.storeName.text = storeModel.shopname;
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:storeModel.doorimg] placeholderImage:[UIImage imageNamed:@"foodImage"]];
    self.distance.text = [NSString stringWithFormat:@"%.2f",storeModel.distance.floatValue];
    self.storeAddress.text = storeModel.addr2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
