//
//  DaLiViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

@interface DaLiViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *daliArea;
@property (weak, nonatomic) IBOutlet UILabel *leftMoney;
@property (weak, nonatomic) IBOutlet UILabel *allInMoney;
@property (weak, nonatomic) IBOutlet UILabel *currentMonthMoney;

@property (weak, nonatomic) IBOutlet UIView *myStoreListView;
@property (weak, nonatomic) IBOutlet UIView *goGetStoreDoorView;
@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UIView *myBCardView;
@property (weak, nonatomic) IBOutlet UIView *shareView;

@end
