//
//  MyBankCardViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
#import "NemberModel.h"

typedef void(^chooseBankBlock) (bankCardModel *mdoel);


@interface MyBankCardViewController : BaseViewController

@property (nonatomic,strong) NSString *type;

@property (nonatomic,copy) chooseBankBlock bankBlock;

@end
