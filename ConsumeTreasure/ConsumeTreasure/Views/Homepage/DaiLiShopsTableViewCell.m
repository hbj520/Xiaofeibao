//
//  DaiLiShopsTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DaiLiShopsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DaiLiShopsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShopMo:(shopModel *)shopMo{
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:shopMo.doorImg] placeholderImage:[UIImage imageNamed:@"miniDefault"]];
    self.shopName.text = shopMo.shopName;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
