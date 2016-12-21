//
//  MemberTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MemberTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMemModel:(NemberModel *)memModel{
    [self.memImg sd_setImageWithURL:[NSURL URLWithString:memModel.imgUrl] placeholderImage:[UIImage imageNamed:@"tx"]];
    self.memName.text = memModel.loginName;
    self.memPhone.text = memModel.phone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
