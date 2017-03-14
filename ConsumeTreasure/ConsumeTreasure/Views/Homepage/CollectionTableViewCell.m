//
//  CollectionTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/3/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)cancelClick:(id)sender {
    NSLog(@"删除");
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (void)setCollectShopMo:(CollectShopListModel *)collectShopMo{
    self.storeName.text = collectShopMo.shopName;
    self.storeAddr.text = collectShopMo.addr;
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:collectShopMo.doorImg] placeholderImage:[UIImage imageNamed:@"miniDefault"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
