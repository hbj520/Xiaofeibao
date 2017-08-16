//
//  TuiJianTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TuiJianTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation TuiJianTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.disCountLab.layer.borderColor = RGBACOLOR(251, 156, 64, 1).CGColor;
    self.disCountLab.layer.cornerRadius = 8;
    self.disCountLab.layer.masksToBounds = YES;


}


- (void)setTuiModel:(TuiJianModel *)tuiModel{
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:tuiModel.doorImg] placeholderImage:[UIImage imageNamed:DEFAULTSTOREIMAGE]];
    self.storeNameLa.text = tuiModel.shopName;
    [self.starV configWithStarLevel:tuiModel.avgScore.floatValue];
    self.pointLab.text = tuiModel.avgScore;
    self.diatanceLab.text = [NSString stringWithFormat:@"%.2fkm",tuiModel.distance.floatValue];
    self.addressLab.text = tuiModel.addr;
    NSArray *strArray = [tuiModel.discount componentsSeparatedByString:@"返币"];
    NSString *subStr = strArray[1];
    NSArray *subArray = [subStr componentsSeparatedByString:@"%"];
    NSString *numStr = subArray[0];
    if (numStr.floatValue == 0) {
        self.diatanceLab.text = @"";
        self.disCountLab.layer.borderWidth = 0;

    }else{
        //self.disCountLab.text = [NSString stringWithFormat:@"%@",tuiModel.discount];
        //self.disCountLab.layer.borderWidth = 1;

    }
    
}
- (void)configWithData:(UnionContenModel *)data{
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:data.doorImg] placeholderImage:[UIImage imageNamed:DEFAULTSTOREIMAGE]];
    self.storeNameLa.text = data.shopName;
    [self.starV configWithStarLevel:data.avgScore.floatValue];
    self.pointLab.text = data.avgScore;
    self.diatanceLab.text = [NSString stringWithFormat:@"%.2fkm",data.distance.floatValue];
    self.addressLab.text = data.addr;
    NSArray *strArray = [data.discount componentsSeparatedByString:@"返币"];
    NSString *subStr = strArray[1];
    NSArray *subArray = [subStr componentsSeparatedByString:@"%"];
    NSString *numStr = subArray[0];
    if (numStr.floatValue == 0) {
        self.disCountLab.text = @"";
        self.disCountLab.layer.borderWidth = 0;

    }else{
        //self.disCountLab.text = [NSString stringWithFormat:@"%@",data.discount];
        //self.disCountLab.layer.borderWidth = 1;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
