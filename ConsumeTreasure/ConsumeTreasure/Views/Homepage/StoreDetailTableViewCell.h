//
//  StoreDetailTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailModel.h"
@interface StoreDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *adresssLab;

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;


@property (nonatomic,strong) StoreDetailModel *deModel;

@property (nonatomic,strong) NSString *phNum;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;


@end
