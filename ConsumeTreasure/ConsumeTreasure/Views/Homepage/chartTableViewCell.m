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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    rateArray = [NSMutableArray array];
    dayArray = [NSMutableArray array];
    
}

- (void)setRateArr:(NSArray *)rateArr{
    
    [rateArray removeAllObjects];
    [dayArray removeAllObjects];
    
    for (ChartModel *model in rateArr) {
        [rateArray addObject:model.rate];
        [dayArray addObject:[Tools timeWithTimeIntervalString:model.createtime]];
             }
    if (rateArray.count > 0) {
        [self creatChartWithRateArr:rateArray DayArr:dayArray];

    }
}


- (void)creatChartWithRateArr:(NSMutableArray *)rateArr DayArr:(NSMutableArray*)dayArr{
    
    
    
    self.foldLineView = [[FoldLineView alloc]initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 220)];
    
     NSMutableArray *timeArr = [NSMutableArray arrayWithObjects:@"1.35",@"0.41",@"0.30",@"0.53",@"2.16",@"3.33",@"2.09",nil];
    
    self.foldLineView.numbers = dayArr;
    self.foldLineView.kmArr = rateArr;
    self.foldLineView.timeArr = timeArr;
    
    [self.contentView addSubview:self.foldLineView];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
