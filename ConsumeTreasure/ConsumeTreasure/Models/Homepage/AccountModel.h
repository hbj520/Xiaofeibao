//
//  AccountModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/25.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol AccountModel

@end

@interface AccountModel : JSONModel
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *createdate;
@property (nonatomic,strong) NSString *createyear;
@property (nonatomic,strong) NSString *account_description;
@property (nonatomic,strong) NSString *goldnum;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *title;


@end

@interface AccountArrayModel : JSONModel
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSArray<AccountModel>* list;
@end


@protocol recordModel
@end

@interface recordModel : JSONModel
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *record_description;
@property (nonatomic,strong) NSString *after_money;
@end

@interface recordArrayModel : JSONModel
@property (nonatomic,strong) NSArray<recordModel>* data;
@end


@protocol searchModel
@end

@interface searchModel : JSONModel
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *avgScore;
@property (nonatomic,strong) NSString *discount;
@property (nonatomic,strong) NSString *doorimg;
@property (nonatomic,strong) NSString *memid;
@property (nonatomic,strong) NSString *shopname;
@end

@interface searchArrayModel : JSONModel
@property (nonatomic,strong) NSArray<searchModel>* data;
@end

