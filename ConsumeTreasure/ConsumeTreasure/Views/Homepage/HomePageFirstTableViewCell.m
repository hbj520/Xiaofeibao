//
//  HomePageFirstTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomePageFirstTableViewCell.h"

@interface HomePageFirstTableViewCell ()
{
    UIView *view2;
}
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selector:)
                                                 name:@"hideWay"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(show:)
                                                 name:@"showWay"
                                               object:nil];

}

#pragma mark - privateMethod
- (void)selector:(NSNotification*)sender{
    NSLog(@"隐藏");
    
    for(view2 in [self.scanView subviews])
    {
        view2.hidden = YES;
    }
    for(view2 in [self.accountView subviews])
    {
        view2.hidden = YES;
    }
    for(view2 in [self.recordView subviews])
    {
        view2 .hidden = YES;
    }
    for(view2 in [self.incomeView subviews])
    {
        view2.hidden = YES;
    }
    
}

- (void)show:(NSNotification*)sender{
    for(view2 in [self.scanView subviews])
    {
        view2.hidden = NO;
    }
    for(view2 in [self.accountView subviews])
    {
        view2.hidden = NO;
    }
    for(view2 in [self.recordView subviews])
    {
        view2 .hidden = NO;
    }
    for(view2 in [self.incomeView subviews])
    {
        view2.hidden = NO;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
