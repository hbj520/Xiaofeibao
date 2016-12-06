//
//  StoreSpecialTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreSpecialTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation StoreSpecialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSpeModel:(SpecialGoodModel *)speModel{
    [self.specialImage sd_setImageWithURL:[NSURL URLWithString:speModel.imgurl] placeholderImage:[UIImage imageNamed:@"special"]];
    self.specialName.text = speModel.name;
    self.specialPrice.text = [NSString stringWithFormat:@"¥%@",speModel.price];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
