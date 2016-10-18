//
//  PartnerTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/17.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapPhoneBlock) ();

@interface PartnerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *StoreName;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (nonatomic,copy) TapPhoneBlock phoneBlock;

@end
