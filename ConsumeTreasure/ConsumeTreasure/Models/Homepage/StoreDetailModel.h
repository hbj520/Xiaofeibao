//
//  StoreDetailModel.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/2.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "JSONModel.h"

@interface StoreDetailModel : JSONModel

@property (nonatomic,strong) NSString *addr2;
@property (nonatomic,strong) NSString *doorImg;
//@property (nonatomic,strong) NSString *endBusinessTime;
@property (nonatomic,strong) NSString<Optional> *introduction;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *branchPhone;
@property (nonatomic,strong) NSString *collect;
//@property (nonatomic,strong) NSString *startBusinessTime;
@end
