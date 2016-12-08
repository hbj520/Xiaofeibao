//
//  AttentionShopTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 16/12/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AttentionReusedId @"attenttionReusedId"
#import "CollectShopListModel.h"
@interface AttentionShopTableViewCell : UITableViewCell
- (void)configWithData:(CollectShopListModel *)data;
@end
