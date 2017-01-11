//
//  StoreDeatilViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeStoreModel.h"

#import "TuiJianModel.h"

#import "LookStoreModel.h"

@interface StoreDeatilViewController : BaseViewController


@property (nonatomic,strong) TuiJianModel *StoreModel;


@property (weak, nonatomic) IBOutlet UILabel *discountBtnLab;

@property (weak, nonatomic) IBOutlet UIButton *collectNewBtn;

@end
