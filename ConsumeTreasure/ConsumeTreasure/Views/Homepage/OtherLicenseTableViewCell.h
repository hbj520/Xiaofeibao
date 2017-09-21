//
//  OtherLicenseTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PhotoBlock) ();
@interface OtherLicenseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (nonatomic,copy) PhotoBlock otherBlock;

@property (weak, nonatomic) IBOutlet UILabel *imgLabel;


@end
