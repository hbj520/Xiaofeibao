//
//  AddBankViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ChooseBankBlock)();

@interface AddBankViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *cardMasterName;
@property (weak, nonatomic) IBOutlet UITextField *cardNum;
@property (weak, nonatomic) IBOutlet UITextField *cardBankName;
@property (weak, nonatomic) IBOutlet UITextField *cardArea;

@property (weak, nonatomic) IBOutlet UIView *oneView;

@property (nonatomic,copy) ChooseBankBlock chooseBank;
@end
