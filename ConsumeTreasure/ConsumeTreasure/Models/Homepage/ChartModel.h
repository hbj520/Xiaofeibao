//
//  ChartModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/7.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol ChartModel

@end



@interface ChartModel : JSONModel

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *isdelete;
@property (nonatomic,strong) NSString *rate;


@end


@interface dataModel : JSONModel
@property (nonatomic,strong) NSArray<ChartModel>*IncomerightRateList;
@end
