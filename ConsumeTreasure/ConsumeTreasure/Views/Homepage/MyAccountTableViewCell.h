//
//  MyAccountTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapViewBlock)();

@interface MyAccountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIButton *applyMoneyBtn;
@property (weak, nonatomic) IBOutlet UILabel *explainLab;

@property (weak, nonatomic) IBOutlet UIView *spreadView;
@property (weak, nonatomic) IBOutlet UIView *partnerCommissionView;
@property (weak, nonatomic) IBOutlet UIView *payBackView;
@property (weak, nonatomic) IBOutlet UIView *otherBenefitView;

@property (nonatomic, copy) TapViewBlock spreadBlock;
@property (nonatomic, copy) TapViewBlock CommissionBlock;
@property (nonatomic, copy) TapViewBlock payBackBlock;
@property (nonatomic, copy) TapViewBlock BenefitBlock;
@property (nonatomic ,copy) TapViewBlock applyBtnBlock;

@end
