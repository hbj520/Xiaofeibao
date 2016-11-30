//
//  ApplyContentTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)();

@interface ApplyContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *trueName;
@property (weak, nonatomic) IBOutlet UITextField *identiNum;
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UITextField *rangeText;

@property (weak, nonatomic) IBOutlet UIButton *chooseRange;

@property (nonatomic,copy)BtnBlock chooseBlock;

@end
