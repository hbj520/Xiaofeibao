//
//  chartTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "chartTableViewCell.h"
#import "FoldLineView.h"

#import "ChartModel.h"

@interface chartTableViewCell ()
{
    NSMutableArray *rateArray;
    NSMutableArray *dayArray;
}
@property(nonatomic,strong)FoldLineView *foldLineView;
@end

@implementation chartTableViewCell

- (void)setRateArr:(NSArray *)rateArr{
    for (ChartModel *model in rateArr) {
        [rateArray addObject:model.rate];
        [dayArray addObject:[Tools dealWithtimeStr:model.createtime] ];
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    rateArray = [NSMutableArray array];
    dayArray = [NSMutableArray array];
    
    self.foldLineView = [[FoldLineView alloc]initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 220)];
    
    //周的数据源
    NSMutableArray *numbers =[NSMutableArray arrayWithObjects:@"28", @"29" , @"30" , @"1" , @"2" , @"3", @"4" ,nil];
    //添加里程数据
    NSMutableArray *kmArr = [NSMutableArray arrayWithObjects:@"26.96",@"20.52",@"26.42",@"39.41",@"27.78",@"32.91",@"25.75", nil];
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
