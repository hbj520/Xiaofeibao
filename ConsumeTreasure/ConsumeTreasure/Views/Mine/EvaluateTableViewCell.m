//
//  EvaluateTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 11/22/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "EvaluateTableViewCell.h"
#import "EvaluateListModel.h"
@interface EvaluateTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageview;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *preEvaluateBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneMoreBtn;

@end
@implementation EvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)oneMoreBtn:(id)sender {
    if (self.clickOneMoreBlock) {
        self.clickOneMoreBlock();
    }
}
- (IBAction)preEvaluaBtn:(id)sender {
    if (self.clickEvaluateBlock) {
        self.clickEvaluateBlock();
    }
}
- (void)configWithData:(EvaluateListModel *)data{
    
}
@end
