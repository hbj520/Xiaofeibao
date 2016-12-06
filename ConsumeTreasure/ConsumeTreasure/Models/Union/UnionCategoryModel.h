//
//  UnionCategoryModel.h
//  ConsumeTreasure
//
//  Created by youyou on 11/7/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UnionCategoryModel : JSONModel
@property (nonatomic,copy) NSString<Optional> *iconurl;
@property (nonatomic,copy) NSString *memid;
@property (nonatomic,copy) NSString *name;
@end
