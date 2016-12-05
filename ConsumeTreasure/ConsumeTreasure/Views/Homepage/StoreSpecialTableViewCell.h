//
//  StoreSpecialTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSpecialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *specialImage;
@property (weak, nonatomic) IBOutlet UILabel *specialName;
@property (weak, nonatomic) IBOutlet UILabel *specialPrice;


@property (nonatomic,strong) NSArray *speArr;

@end
