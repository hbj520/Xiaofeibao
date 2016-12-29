//
//  TuiJianModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"


@protocol TuiJianModel
@end

@interface TuiJianModel : JSONModel

@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *doorImg;
@property (nonatomic,strong) NSString *memid;
@property (nonatomic,strong) NSString *avgScore;
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *discount;


@end



@interface arratModel : JSONModel

@property (nonatomic,strong) NSArray<TuiJianModel>* memList;
//@property (nonatomic,strong) NSArray<TuiJianModel>* shoplist;


@end
