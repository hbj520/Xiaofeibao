//
//  HotStoreTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeStoreModel.h"

@interface HotStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
//@property (weak, nonatomic) IBOutlet UILabel *storeLikeNum;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *discountLab;

@property (nonatomic,strong)HomeStoreModel* storeModel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;

@end
