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
    self.discountLab.layer.borderColor = RGBACOLOR(251, 156, 64, 1).CGColor;
    self.discountLab.layer.borderWidth = 1;
    self.discountLab.layer.cornerRadius = 8;
    self.discountLab.layer.masksToBounds = YES;
}

- (void)setStoreModel:(HomeStoreModel *)storeModel{
    self.storeName.text = storeModel.shopname;
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:storeModel.doorimg] placeholderImage:[UIImage imageNamed:DEFAULTSTOREIMAGE]];
    self.distance.text = [NSString stringWithFormat:@"%.2fkm",storeModel.distance.floatValue];
    self.storeAddress.text = storeModel.addr;
    self.discountLab.text = [NSString stringWithFormat:@"%@",storeModel.discount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
