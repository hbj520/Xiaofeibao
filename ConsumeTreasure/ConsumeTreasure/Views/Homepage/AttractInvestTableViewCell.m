//
//  AttractInvestTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/24.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "AttractInvestTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface AttractInvestTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation AttractInvestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configWithData:(AttractInvestModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"tx"]];
    self.levelLabel.text = model.agentType;
    self.nameLabel.text = model.name;
}
@end
