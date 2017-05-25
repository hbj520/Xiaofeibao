//
//  CashBankRecordTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/25.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyCashModel.h"
#define CashBankReuseId @"CashBankRecordTableViewCellID"
@interface CashBankRecordTableViewCell : UITableViewCell
- (void)configData:(ApplyCashModel *)data;
@end
