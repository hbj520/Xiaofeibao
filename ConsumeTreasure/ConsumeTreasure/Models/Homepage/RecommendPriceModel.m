//
//  RecommendPriceModel.m
//  ConsumeTreasure
//
//  Created by youyou on 17/4/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "RecommendPriceModel.h"

@implementation RecommendPriceModel

@end

@implementation RecommendPriceArrayModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"record_description"}];
}

@end
