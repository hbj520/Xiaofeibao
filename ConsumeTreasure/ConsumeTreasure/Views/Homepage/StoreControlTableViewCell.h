//
//  StoreControlTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpPikerViewBlock)();

@interface StoreControlTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UITextField *placetextfield;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;

@property (nonatomic ,copy) UpPikerViewBlock pikerBlock;

@end
