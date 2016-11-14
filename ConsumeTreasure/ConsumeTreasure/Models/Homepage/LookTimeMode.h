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
