//
//  LevelTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface LevelTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *changeImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *changeNum;

@property (nonatomic, strong) AccountModel *accountModel;

@property (nonatomic, strong) NSMutableArray *arr;

@end
