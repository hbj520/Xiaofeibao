//
//  CashViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

@interface CashViewController : BaseViewController

@property (nonatomic,strong) NSArray *incomeMoney;


@property (weak, nonatomic) IBOutlet UILabel *dayIncome;
@property (weak, nonatomic) IBOutlet UILabel *allIncome;

@end
