//
//  BankCardTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NemberModel.h"
@interface BankCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UILabel *cardType;
@property (weak, nonatomic) IBOutlet UILabel *cardNum;

@property (nonatomic,strong) bankCardModel *bankModel;

@end
