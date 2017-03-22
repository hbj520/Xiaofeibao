//
//  StoreMasterModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreMasterModel : JSONModel
@property (nonatomic,strong) NSString *history_withdrawal;//
@property (nonatomic,strong) NSString *today_withdrawal;//余额
@property (nonatomic,strong) NSString *day_turnover;//日成交额
@property (nonatomic,assign) double money;//余额
@property (nonatomic,assign) double turnover;//累计成交额
@property (nonatomic,assign) double total;//订单总数
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


//商户资料查询
@interface storeInfoModel : JSONModel
@property (nonatomic,strong) NSString *shopname;//店名
@property (nonatomic,strong) NSString *shopPhone;//门面电话
@property (nonatomic,strong) NSString *name;//真实姓名
@property (nonatomic,strong) NSString *idcardno;//身份证号

@property (nonatomic,strong) NSString *addr;//地址
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;//定位坐标
@property (nonatomic,strong) NSString *introduction;//商家介绍
@property (nonatomic,strong) NSString *startbusinesstime;//开始时间
@property (nonatomic,strong) NSString *endbusinesstime;//结束时间
@property (nonatomic,strong) NSString *discount;//反比比例
@property (nonatomic,strong) NSString *categoryid;//经营分类

@property (nonatomic,strong) NSString *businessimg;//营业执照
@property (nonatomic,strong) NSString *licenseimg;//许可证
@property (nonatomic,strong) NSString *idcardnofrontimg;//正面
@property (nonatomic,strong) NSString *idcardnobackimg;//反面
@property (nonatomic,strong) NSString *doorimg;//反面

@end



