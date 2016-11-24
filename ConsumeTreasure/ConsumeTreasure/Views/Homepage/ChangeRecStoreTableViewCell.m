//
//  ChangeRecStoreTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "TuiJianModel.h"

#import "ChangeRecStoreTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation ChangeRecStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addTapGes];
}

- (void)addTapGes{
    UITapGestureRecognizer *oneGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneGes:)];
    [self.oneView addGestureRecognizer:oneGes];
    UITapGestureRecognizer *twoGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoGes:)];
    [self.twoView addGestureRecognizer:twoGes];
    UITapGestureRecognizer *threeGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(threeGes:)];
    [self.threeView addGestureRecognizer:threeGes];
}

-(void)oneGes:(id)Ges{
    if (self.oneBlock) {
        self.oneBlock();
    }
}

-(void)twoGes:(id)Ges{
    if (self.twoBlock) {
        self.twoBlock();
    }
}

-(void)threeGes:(id)Ges{
    if (self.threeBlock) {
        self.threeBlock();
    }
}

- (void)setStoreArray:(NSMutableArray *)storeArray{
    if (storeArray.count >0) {
        TuiJianModel *model0 = [storeArray objectAtIndex:0];
        self.oneName.text = model0.shopName;
        [self.oneImage sd_setImageWithURL:[NSURL URLWithString:model0.doorImg] placeholderImage:[UIImage imageNamed:@"pic_720"]];
        
        TuiJianModel *model1 = [storeArray objectAtIndex:1];
        self.twoName.text = model1.shopName;
        [self.twoImage sd_setImageWithURL:[NSURL URLWithString:model1.doorImg] placeholderImage:[UIImage imageNamed:@"pic_720"]];
        
        TuiJianModel *model2 = [storeArray objectAtIndex:2];
        self.threeName.text = model2.shopName;
        [self.threeImage sd_setImageWithURL:[NSURL URLWithString:model2.doorImg] placeholderImage:[UIImage imageNamed:@"pic_720"]];
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
