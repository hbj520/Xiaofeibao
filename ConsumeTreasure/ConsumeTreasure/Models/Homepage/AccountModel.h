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
