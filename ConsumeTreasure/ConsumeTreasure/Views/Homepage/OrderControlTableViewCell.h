//
//  OrderControlTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderConModel.h"

@interface OrderControlTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (nonatomic,strong) OrderConModel *orderModel;

@end
