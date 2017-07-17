//
//  OrderConModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol OrderConModel

@end

@interface OrderConModel : JSONModel

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString<Optional> *loginName;
@property (nonatomic,strong) NSString *pay_number;
@property (nonatomic,strong) NSString *pay_status;
@property (nonatomic,strong) NSString *total_money;
@property (nonatomic,strong) NSString *order_description;


@end

@interface orderArrayModel : JSONModel
@property (nonatomic,strong) NSArray<OrderConModel>* payorderList;
@end


/*
 收益明细（代理）
 */
@protocol DaLiIncomeModel

@end

@interface DaLiIncomeModel : JSONModel

@property (nonatomic,strong) NSString *bill_description;
@property (nonatomic,strong) NSString *createdate;
@property (nonatomic,strong) NSString *createyear;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) double money;
@property (nonatomic,assign) double after_money;
@property (nonatomic,strong) NSString *type;


@end

@interface incomeArrModel : JSONModel
@property (nonatomic,strong) NSArray<DaLiIncomeModel>* billlogList;
@end


/*
 收益明细（商户）
 */
@protocol ShangHuIncomeModel

@end

@interface ShangHuIncomeModel : JSONModel

@property (nonatomic,strong) NSString *shop_description;
@property (nonatomic,strong) NSString *createdate;
@property (nonatomic,strong) NSString *createyear;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) double money;
@property (nonatomic,assign) double after_money;
@property (nonatomic,strong) NSString *type;


@end

@interface ShangHuincomeArrModel : JSONModel
@property (nonatomic,strong) NSArray<ShangHuIncomeModel>* shopList;
@end
/*
 收益明细（招商联盟）
 */
@protocol InvestIncomeModel

@end

@interface InvestIncomeModel : JSONModel

@property (nonatomic,strong) NSString *record_description;
@property (nonatomic,strong) NSString *createdate;
@property (nonatomic,strong) NSString *createyear;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *after_money;
@property (nonatomic,strong) NSString<Optional>  *type;

@end

@interface InvestIncomeArrModel : JSONModel
@property (nonatomic,strong) NSArray<InvestIncomeModel>* billlogList;
@end
