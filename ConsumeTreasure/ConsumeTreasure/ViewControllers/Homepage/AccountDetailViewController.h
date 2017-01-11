//
//  AccountDetailViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountModel.h"
#import "OrderConModel.h"
@interface AccountDetailViewController : BaseViewController

@property (nonatomic,strong) AccountModel *model;
@property (nonatomic,strong) ShangHuIncomeModel *shanghuModel;
@property (nonatomic,strong) DaLiIncomeModel *daliModel;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *accountChangeLab;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab2;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *yearLab;

@property (weak, nonatomic) IBOutlet UILabel *actionTimeLab;
@property (weak, nonatomic) IBOutlet UITextView *accountDescripTextView;

@property (weak, nonatomic) IBOutlet UILabel *changeStr;


@end
