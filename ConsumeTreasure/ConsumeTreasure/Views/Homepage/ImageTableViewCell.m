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
@interface ImageTableViewCell()<SDCycleScrollViewDelegate>

@end

@implementation ImageTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  [self urlPhoto];
    
}
//网络图片
- (void)urlPhoto
{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    SDCycleScrollView * cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:self.contentView.frame delegate:self placeholderImage:[UIImage imageNamed:@"theimage"]];
    cycleScrollView2.pageControlAliment = 0;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.pageControlStyle = 1;
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView2.pageControlDotSize = CGSizeMake(6, 6);
    //加载网络图片
    [self.contentView addSubview:cycleScrollView2];
    [cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(self.contentView.frame.size.width));
        make.bottom.equalTo(@0);
    }];
}
//点击图片方法
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"%ld",(long)index);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
