//
//  BeUnionModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol BeUnionModel

@end

@interface BeUnionModel : JSONModel

@property (nonatomic,strong) NSString *iconurl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *turnover;
@end


@interface arrayUnionModel : JSONModel

@property (nonatomic,strong) NSString *clause;
@property (nonatomic,strong) NSArray<BeUnionModel>* list;
@end
