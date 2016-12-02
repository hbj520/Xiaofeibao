//
//  SpecialGoodModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol SpecialGoodModel

@end

@interface SpecialGoodModel : JSONModel

@property (nonatomic,strong) NSString *imgurl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;

@end


@interface arraySpeModel : JSONModel

@property (nonatomic,strong) NSArray<SpecialGoodModel>*products;

@end
