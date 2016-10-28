//
//  PartnerTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
typedef void (^TapPhoneBlock) ();

@interface PartnerTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storeDetailLab;
@property (weak, nonatomic) IBOutlet starView *starView;
@property (weak, nonatomic) IBOutlet UILabel *evaluatePointLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (nonatomic,copy) TapPhoneBlock phoneBlock;

@end
