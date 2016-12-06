//
//  EstimateTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "EstimateTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "starView.h"

@implementation EstimateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCommModel:(CommentModel *)commModel{
    self.estimateName.text = commModel.membername;
    self.estimateTime.text = commModel.createdate;
    [self.estimateImage sd_setImageWithURL:[NSURL URLWithString:commModel.imgUrl] placeholderImage:[UIImage imageNamed:@"special"]];
     [self.estimateStar configWithStarLevel:commModel.totalScore.floatValue];
    self.estimateContent.text = commModel.content;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
