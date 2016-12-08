//
//  ImageTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "SDCycleScrollView.h"
#import <Masonry.h>
#import "AddModel.h"
@interface ImageTableViewCell()<SDCycleScrollViewDelegate>
{
    NSMutableArray *_imageArr;
}

@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageArr = [NSMutableArray array];
}

- (void)setAddArray:(NSMutableArray *)addArray{
    
    [_imageArr removeAllObjects];
    for (AddModel *admodel in addArray) {
        [_imageArr addObject:admodel.adimg];
    }
    [self addImageWithArray:_imageArr];
}

- (void)addImageWithArray:(NSMutableArray*)arr
{
    
    
    SDCycleScrollView * cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:self.contentView.frame delegate:self placeholderImage:[UIImage imageNamed:@"theimage"]];
    cycleScrollView2.pageControlAliment = 0;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.pageControlStyle = 1;
    cycleScrollView2.imageURLStringsGroup = arr;
    cycleScrollView2.pageControlDotSize = CGSizeMake(6, 6);
    //加载网络图片
    [self.contentView addSubview:cycleScrollView2];
    [cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@0);
        make.width.equalTo(@(self.contentView.frame.size.width));
        
        make.height.equalTo(@(self.contentView.frame.size.height-40));
        make.bottom.equalTo(@20);
    }];
}

//点击图片方法
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    if (self.indexBlock) {
        self.indexBlock(index);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
