//
//  RecommendTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 17/4/13.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendPriceModel.h"
#define RecommendReuseId @"recommendCellReuseId"
@interface RecommendTableViewCell : UITableViewCell
- (void)configWithData:(RecommendPriceModel *)model;
@end
