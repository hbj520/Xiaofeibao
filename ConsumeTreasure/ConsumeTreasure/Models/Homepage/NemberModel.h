//
//  NemberModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@protocol NemberModel

@end

@interface NemberModel : JSONModel
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *loginName;
@property (nonatomic,strong) NSString *phone;


@end


@interface listModel : JSONModel

@property (nonatomic,strong) NSArray<NemberModel>* memList;
@end
