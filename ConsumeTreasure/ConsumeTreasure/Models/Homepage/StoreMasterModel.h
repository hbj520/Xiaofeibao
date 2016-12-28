//
//  StoreMasterModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreMasterModel : JSONModel
@property (nonatomic,strong) NSString *day_turnover;//日成交额
@property (nonatomic,strong) NSString *money;//余额
@property (nonatomic,strong) NSString *turnover;//累计成交额
@property (nonatomic,strong) NSString *total;//订单总数
@property (nonatomic,strong) NSString *shopName;//商户名称


@end


@interface DaLiMasterModel : JSONModel
@property (nonatomic,strong) NSString *proxyname;
@property (nonatomic,strong) NSString *day_money;//日收入
@property (nonatomic,strong) NSString *type;//代理类型
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *month_money;//月累计收入
@property (nonatomic,strong) NSString *total_money;//累计收入


@end
