//
//  MyIncomeTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapViewBlock)();
@interface MyIncomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *backBtn;


@property (nonatomic ,copy) TapViewBlock backBtnBlock;
@end
