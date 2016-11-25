//
//  ZanTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 11/25/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "ZanTableViewCell.h"
@interface ZanTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIView *zanView;

@end
@implementation ZanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
    // Initialization code
}
- (void)createUI{
    self.zanView.layer.cornerRadius = 13;
    self.downView.layer.cornerRadius = 13;
    self.zanView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.downView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.zanView.layer.borderWidth = 1;
    self.downView.layer.borderWidth = 1;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
