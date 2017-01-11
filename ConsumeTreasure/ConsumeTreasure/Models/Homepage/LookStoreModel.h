//
//  LookStoreModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface LookStoreModel : JSONModel

@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString <Optional>*doorImg;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *discount;
@property (nonatomic,strong) NSString *memid;
@property (nonatomic,strong) NSString *browseDate;
@end

@interface locationModel : JSONModel

@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *cityCode;

@end
