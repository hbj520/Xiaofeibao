//
//  MemberTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NemberModel.h"
@interface MemberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *memImg;
@property (weak, nonatomic) IBOutlet UILabel *memName;
@property (weak, nonatomic) IBOutlet UILabel *memPhone;

@property (nonatomic,strong) NemberModel *memModel;

@end
