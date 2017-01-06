//
//  StoreDetailModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreDetailModel : JSONModel

@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *doorImg;
//@property (nonatomic,strong) NSString *endBusinessTime;
@property (nonatomic,strong) NSString<Optional> *introduction;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopPhone;
@property (nonatomic,strong) NSString *collect;
@property (nonatomic,assign) double shopReturnRate;

@property (nonatomic,strong) NSString<Optional> *longitude;
@property (nonatomic,strong) NSString<Optional> *latitude;
//@property (nonatomic,strong) NSString *startBusinessTime;
@end
