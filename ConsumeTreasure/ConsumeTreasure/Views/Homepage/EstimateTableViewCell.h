//
//  EstimateTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
@interface EstimateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *estimateImage;
@property (weak, nonatomic) IBOutlet UILabel *estimateName;
@property (weak, nonatomic) IBOutlet starView *estimateStar;
@property (weak, nonatomic) IBOutlet UILabel *estimateTime;
@property (weak, nonatomic) IBOutlet UILabel *estimateContent;

@end
