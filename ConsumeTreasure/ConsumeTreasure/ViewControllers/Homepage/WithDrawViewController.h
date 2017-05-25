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
- (IBAction)cashCardRecordBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cashCardBtn;

@property (nonatomic,strong) NSArray *moneyType;
@property (nonatomic,assign) BOOL isInvest;//是否为招商联盟进入


@end
