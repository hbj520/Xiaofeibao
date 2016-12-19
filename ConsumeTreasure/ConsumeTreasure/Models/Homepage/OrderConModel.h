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
@property (nonatomic,strong) NSString *loginName;
@property (nonatomic,strong) NSString *pay_number;
@property (nonatomic,strong) NSString *pay_status;
@property (nonatomic,strong) NSString *total_money;
@property (nonatomic,strong) NSString *order_description;


@end

@interface orderArrayModel : JSONModel
@property (nonatomic,strong) NSArray<OrderConModel>* payorderList;
@end
