//
//  StoreMasterModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreMasterModel : JSONModel

@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *turnover;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *shopName;


@end


@interface DaLiMasterModel : JSONModel

@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *month_money;
@property (nonatomic,strong) NSString *total_money;


@end
