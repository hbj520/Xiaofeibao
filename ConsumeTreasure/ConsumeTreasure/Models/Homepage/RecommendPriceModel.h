//
//  RecommendPriceModel.h
//  ConsumeTreasure
//
//  Created by youyou on 17/4/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "JSONModel.h"
@protocol RecommendPriceModel

@end

@interface RecommendPriceModel : JSONModel
@property (nonatomic, strong) NSString *createdate;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *phone;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

@interface RecommendPriceArrayModel : JSONModel
@property (nonatomic, strong) NSString *adimg;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSArray <RecommendPriceModel>*moneyList;
@property (nonatomic, strong) NSString *url;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
