//
//  HomeStoreModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/3.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol  HomeStoreModel

@end

@interface HomeStoreModel : JSONModel

@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *doorimg;
@property (nonatomic,strong) NSString *memid;
@property (nonatomic,strong) NSString *shopname;
@property (nonatomic,strong) NSString *addr;

@end


@interface HomeArraymodel : JSONModel

@property (nonatomic,strong) NSArray <HomeStoreModel>*memberPojoList;

@end
