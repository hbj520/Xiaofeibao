//
//  LookTimeMode.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol LookTimeMode
@end

@interface LookTimeMode : JSONModel
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSArray *mlist;
@end


@interface mapListModel : JSONModel
@property (nonatomic,strong) NSArray<LookTimeMode>* mapList;

@end


@protocol provinceModel
@end

@interface provinceModel : JSONModel
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSArray *clist;
@end


@interface pcListModel : JSONModel
@property (nonatomic,strong) NSArray<provinceModel>* pcList;

@end
