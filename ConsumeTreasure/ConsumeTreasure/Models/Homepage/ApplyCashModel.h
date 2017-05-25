//
//  ApplyCashModel.h
//  ConsumeTreasure
//
//  Created by youyou on 2017/5/25.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ApplyCashModel

@end
@interface ApplyCashModel : JSONModel
@property (nonatomic,strong) NSString *bankname;
@property (nonatomic,strong) NSString *bankno;
@property (nonatomic,strong) NSString *bankusername;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *ratemoney;
@property (nonatomic,strong) NSString *realPaymoney;
@property (nonatomic,strong) NSString *status;
@end

@interface ApplyCashModelArray : JSONModel
@property (nonatomic,strong) NSArray<ApplyCashModel> *appliWithdrawallist;

@end
