//
//  GoPrePayViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "XWMoneyTextField.h"
@interface GoPrePayViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UILabel *leftTongMoney;
@property (weak, nonatomic) IBOutlet UILabel *disCountMoney;
@property (weak, nonatomic) IBOutlet UILabel *realPay;
@property (weak, nonatomic) IBOutlet UILabel *getTongMoney;

@property (weak, nonatomic) IBOutlet UIButton *useLeftMoneyBtn;

@property (weak, nonatomic) IBOutlet UIView *tfView;

@end
