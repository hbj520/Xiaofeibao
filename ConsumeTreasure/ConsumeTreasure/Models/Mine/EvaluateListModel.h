//
//  EvaluateListModel.h
//  ConsumeTreasure
//
//  Created by youyou on 12/2/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EvaluateListModel : JSONModel
@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *pay_status;
@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *doorImg;
@property (nonatomic,copy) NSString<Optional> *total_money;
@end
