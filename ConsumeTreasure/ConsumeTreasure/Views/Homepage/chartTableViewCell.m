//
//  chartTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "chartTableViewCell.h"
#import "FoldLineView.h"

@interface chartTableViewCell ()
@property(nonatomic,strong)FoldLineView *foldLineView;
@end

@implementation chartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.foldLineView = [[FoldLineView alloc]initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 220)];
    
    //周的数据源
    NSMutableArray *numbers =[NSMutableArray arrayWithObjects:@"28", @"29" , @"30" , @"1" , @"2" , @"3", @"4" ,nil];
    //添加里程数据
    NSMutableArray *kmArr = [NSMutableArray arrayWithObjects:@"88",@"32",@"12",@"38",@"87.5",@"130.5",@"131", nil];
    //添加时间数组
    NSMutableArray *timeArr = [NSMutableArray arrayWithObjects:@"1.35",@"0.41",@"0.30",@"0.53",@"2.16",@"3.33",@"2.09",nil];
    
    self.foldLineView.numbers = numbers;
    self.foldLineView.kmArr = kmArr;
    self.foldLineView.timeArr = timeArr;
    
    [self.contentView addSubview:self.foldLineView];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
