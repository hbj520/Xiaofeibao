//
//  LianmenRightCollectionViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 10/19/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "LianmenRightCollectionViewCell.h"
#import "UnionCategoryModel.h"
@interface LianmenRightCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *lianmenItemImageView;
@property (weak, nonatomic) IBOutlet UILabel *lianmenItemTitle;

@end
@implementation LianmenRightCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configWithData:(UnionCategoryModel *)model{
    self.lianmenItemImageView.image = [UIImage imageNamed:model.iconurl];
    self.lianmenItemTitle.text = model.name;
}
@end
