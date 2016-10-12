//
//  HomePageFirstTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageFirstTableViewCell.h"

@interface HomePageFirstTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UIView *partnerStoreView;

@end


@implementation HomePageFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addTapGesture];
}

- (void)addTapGesture{
    UITapGestureRecognizer *tapScan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScan:)];
    [self.scanView addGestureRecognizer:tapScan];
    
    UITapGestureRecognizer *tapAccount = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAccount:)];
    [self.accountView addGestureRecognizer:tapAccount];
    
    UITapGestureRecognizer *tapRecord = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecord:)];
    [self.recordView addGestureRecognizer:tapRecord];
    
    UITapGestureRecognizer *tapIncome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIncome:)];
    [self.incomeView addGestureRecognizer:tapIncome];
    
}

- (void)tapScan:(id)Ges{
    NSLog(@"付款");
    if (self.scanBlock) {
        self.scanBlock();
    }
}

- (void)tapAccount:(id)Ges{
    NSLog(@"账户");
    if (self.accountBlock) {
        self.accountBlock();
    }
}

- (void)tapRecord:(id)Ges{
    NSLog(@"记录");
    if (self.recordBlock) {
        self.recordBlock();
    }
}

- (void)tapIncome:(id)Ges{
    NSLog(@"收益权");
    if (self.incomeBlock) {
        self.incomeBlock();
    }
}

- (IBAction)paetnerClick:(id)sender {
    NSLog(@"合伙人超市");
}

- (IBAction)storeDoor:(id)sender {
    NSLog(@"商户入口");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
