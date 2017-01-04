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
 收益明细
 */
@protocol DaLiIncomeModel

@end

@interface DaLiIncomeModel : JSONModel

@property (nonatomic,strong) NSString *bill_description;
@property (nonatomic,strong) NSString *createdate;
//@property (nonatomic,strong) NSString *money;
@property (nonatomic,assign) double money;
@property (nonatomic,strong) NSString *type;


@end

@interface incomeArrModel : JSONModel
@property (nonatomic,strong) NSArray<DaLiIncomeModel>* billlogList;
@end

