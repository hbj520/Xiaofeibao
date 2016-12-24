//
//  DaiLiShopsTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NemberModel.h"
@interface DaiLiShopsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (nonatomic,strong) shopModel *shopMo;

@end
