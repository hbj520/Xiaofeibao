//
//  UnionContenModel.h
//  ConsumeTreasure
//
//  Created by youyou on 11/18/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UnionContenModel : JSONModel
@property (nonatomic,copy) NSString<Optional> *addr;
@property (nonatomic,copy) NSString<Optional> *avgScore;
@property (nonatomic,copy) NSString<Optional> *distance;
@property (nonatomic,copy) NSString<Optional> *doorImg;
@property (nonatomic,copy) NSString<Optional> *memid;
@property (nonatomic,copy) NSString<Optional> *shopName;
@property (nonatomic,strong) NSString *discount;

@end
