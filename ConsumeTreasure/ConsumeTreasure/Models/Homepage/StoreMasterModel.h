//
//  StoreMasterModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreMasterModel : JSONModel
@property (nonatomic,strong) NSString *history_withdrawal;//日成交额
@property (nonatomic,strong) NSString *today_withdrawal;//余额
@property (nonatomic,strong) NSString *day_turnover;//日成交额
@property (nonatomic,strong) NSString *money;//余额
@property (nonatomic,strong) NSString *turnover;//累计成交额
@property (nonatomic,strong) NSString *total;//订单总数
@property (nonatomic,strong) NSString *shopName;//商户名称
@property (nonatomic,strong) NSString *memid;//商户id

@end


@interface DaLiMasterModel : JSONModel
@property (nonatomic,strong) NSString *today_withdrawal;
@property (nonatomic,strong) NSString *history_withdrawal;//日收入
@property (nonatomic,strong) NSString *proxyname;
@property (nonatomic,strong) NSString *day_money;//日收入
@property (nonatomic,strong) NSString *type;//代理类型
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *month_money;//月累计收入
@property (nonatomic,strong) NSString *total_money;//累计收入


@end


//商户资料
@interface storeInfoModel : JSONModel
@property (nonatomic,strong) NSString *name;//不要
@property (nonatomic,strong) NSString *idcardno;//不要
@property (nonatomic,strong) NSString *addr;//
@property (nonatomic,strong) NSString *doorimg;//日收入
@property (nonatomic,strong) NSString *shopname;//代理类型
@property (nonatomic,strong) NSString *categoryid;
@property (nonatomic,strong) NSString *businessimg;//月累计收入
@property (nonatomic,strong) NSString *licenseimg;//累计收入
@property (nonatomic,strong) NSString *idcardnofrontimg;//日收入
@property (nonatomic,strong) NSString *idcardnobackimg;
@property (nonatomic,strong) NSString *introduction;//日收入
@property (nonatomic,strong) NSString *startbusinesstime;//代理类型
@property (nonatomic,strong) NSString *endbusinesstime;


@end



