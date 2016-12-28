//
//  WithDrawViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "XWMoneyTextField.h"

@interface WithDrawViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *defaultBank;
@property (weak, nonatomic) IBOutlet UILabel *defaultBankNum;
@property (weak, nonatomic) IBOutlet UILabel *defaultCardType;
@property (weak, nonatomic) IBOutlet UILabel *chargeNum;

@property (weak, nonatomic) IBOutlet UILabel *leftMoney;



@property (weak, nonatomic) IBOutlet UIView *withdrawView;



@end
