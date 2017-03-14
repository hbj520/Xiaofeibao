//
//  CollectShopListModel.h
//  ConsumeTreasure
//
//  Created by youyou on 12/6/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CollectShopListModel : JSONModel
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *memid;
@property (nonatomic,copy) NSString *doorImg;
@property (nonatomic,copy) NSString *addr;
@end
