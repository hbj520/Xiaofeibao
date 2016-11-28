//
//  LevelTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "LevelTableViewCell.h"

@implementation LevelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAccountModel:(AccountModel *)accountModel{
    if (accountModel) {
        
        self.timeLab.text = [Tools dealWithtimeStr:accountModel.createdate];
        
        if ([accountModel.type isEqualToString:@"0"]) {
            self.changeImage.image = [UIImage imageNamed:@"zhi"];
            self.changeNum.text = [NSString stringWithFormat:@"- %@",accountModel.goldnum];
        }else{
            self.changeImage.image = [UIImage imageNamed:@"shou"];
            self.changeNum.text = [NSString stringWithFormat:@"+ %@",accountModel.goldnum];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
