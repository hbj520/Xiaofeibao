//
//  PersonInfoModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface PersonInfoModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *isshopchecked;
@property (nonatomic,strong) NSString<Optional> *isproxychecked;
@property (nonatomic,strong) NSString<Optional> *name;

@end


@interface tongBaoModel : JSONModel

@property (nonatomic,strong) NSString *goldNum;
@property (nonatomic,strong) NSString *hasPayPwd;
@end
