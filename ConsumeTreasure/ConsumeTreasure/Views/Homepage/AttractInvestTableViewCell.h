//
//  AttractInvestTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/24.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractInvestModel.h"
#define ATTRACTCELLREUSEID @"AttractInvestReuseID"
@interface AttractInvestTableViewCell : UITableViewCell
- (void)configWithData:(AttractInvestModel *)model;
@end
