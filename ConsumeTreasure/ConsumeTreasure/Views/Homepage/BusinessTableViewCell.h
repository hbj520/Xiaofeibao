//
//  BusinessTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PhotoBlock) ();
@interface BusinessTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *licenseBtn;
@property (nonatomic,copy) PhotoBlock licenseBlock;
@end
