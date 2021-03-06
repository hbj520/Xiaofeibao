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
@property (nonatomic,assign) double money;//营收可提现金额
@property (nonatomic,assign) double turnover;//累计成交额
@property (nonatomic,assign) double total;//订单总数
@property (nonatomic,strong) NSString *shopName;//商户名称
@property (nonatomic,strong) NSString *memid;//商户id
@property (nonatomic,strong) NSString *shop_money;//通宝币可提现金额
@property (nonatomic,strong) NSString *total_money;//商户总金额
@property (nonatomic,strong) NSString *settlementing_money;//在途金额
@property (nonatomic,strong) NSString *withdrawal_money;//可提现总金额

@end


@interface DaLiMasterModel : JSONModel
@property (nonatomic,strong) NSString *today_withdrawal;
@property (nonatomic,strong) NSString *history_withdrawal;//日收入
@property (nonatomic,strong) NSString *proxyname;
@property (nonatomic,strong) NSString *day_money;//日收入
@property (nonatomic,strong) NSString *type;//代理类型
@property (nonatomic,strong) NSString *balance;//代理商账户总余额
@property (nonatomic,strong) NSString *month_money;//月累计收入
@property (nonatomic,strong) NSString *total_money;//累计收入
@property (nonatomic,strong) NSString *settlementing_money;//在途金额
@property (nonatomic,strong) NSString *shop_money;

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


@property (nonatomic,strong) NSString *businessimg;//营业执照
@property (nonatomic,strong) NSString *licenseimg;//许可证
@property (nonatomic,strong) NSString *idcardnofrontimg;//正面
@property (nonatomic,strong) NSString *idcardnobackimg;//反面
@property (nonatomic,strong) NSString *doorimg;//反面

// 新增
@property (nonatomic,strong) NSString *servicephone;//客服电话
@property (nonatomic,strong) NSString *aliasname;//商户简称
@property (nonatomic,strong) NSString *email;// 联系人邮箱
@property (nonatomic,strong) NSString *cardno;//银行卡号
@property (nonatomic,strong) NSString *cardname;//银行卡持卡人姓名
@property (nonatomic,strong) NSString *businessLicense;//营业执照编号

@property (nonatomic,strong) NSString *categorynanme;// "经营类型名称
@property (nonatomic,strong) NSString *contactname;//联系人类型名称
@property (nonatomic,strong) NSString *addressname;//地址类型名称
@property (nonatomic,strong) NSString *businesslicensename;//营业执照类型名称

@property (nonatomic,strong) NSString *categoryid;//经营分类id
@property (nonatomic,strong) NSString *contacttype;//联系人类型id
@property (nonatomic,strong) NSString *addresstype;//地址类型id
@property (nonatomic,strong) NSString *businesslicensetype;//营业执照类型id

@end



