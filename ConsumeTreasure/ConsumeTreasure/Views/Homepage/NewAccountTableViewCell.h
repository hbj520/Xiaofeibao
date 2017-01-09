//
//  NewAccountTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/1/6.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
@interface NewAccountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayTimeStr;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeStr;
@property (weak, nonatomic) IBOutlet UIImageView *shouzhiImage;
@property (weak, nonatomic) IBOutlet UILabel *moneyStr;


@property (nonatomic, strong) AccountModel *accountModel;

@end
