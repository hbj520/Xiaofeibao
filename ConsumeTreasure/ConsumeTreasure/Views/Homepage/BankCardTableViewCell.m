//
//  BankCardTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BankCardTableViewCell.h"

@implementation BankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
}

- (void)setFrame:(CGRect)frame {
    
    static CGFloat const margin = 10;
    
    frame.size.width -= 2 * margin;
    frame.origin.x = margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setBankModel:(bankCardModel *)bankModel{
    self.cardName.text = bankModel.bankname;
    self.cardType.text = @"借记卡";
    self.cardNum.text = bankModel.bankno;
}

- (IBAction)delete:(id)sender {

    NSLog(@"删除");
    if (self.deleteBlock) {
        self.deleteBlock();
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
