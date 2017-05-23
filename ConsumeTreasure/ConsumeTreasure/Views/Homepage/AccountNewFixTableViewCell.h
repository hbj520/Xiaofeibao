//
//  AccountNewFixTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 2017/5/16.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccountModel.h"
#import "OrderConModel.h"

@interface AccountNewFixTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *payWayType;

@property (weak, nonatomic) IBOutlet UILabel *leftMoney;
@property (weak, nonatomic) IBOutlet UILabel *payTime;
@property (weak, nonatomic) IBOutlet UILabel *moneyNum;



@property (nonatomic, strong) AccountModel *accountModel;
@property (nonatomic, strong) ShangHuIncomeModel *shanghuModel;
@property (nonatomic, strong) DaLiIncomeModel *daliModel;
@end
