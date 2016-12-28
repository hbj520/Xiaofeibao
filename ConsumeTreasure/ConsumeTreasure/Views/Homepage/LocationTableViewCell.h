//
//  LocationTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LookStoreModel.h"

@interface LocationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (nonatomic,strong) locationModel *model;

@end
