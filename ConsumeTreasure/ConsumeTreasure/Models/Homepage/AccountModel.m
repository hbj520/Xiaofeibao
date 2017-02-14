//
//  AccountModel.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/25.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
@end

@implementation AccountArrayModel
@end


@implementation recordModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"record_description"}];
}

@end

@implementation recordArrayModel
@end
