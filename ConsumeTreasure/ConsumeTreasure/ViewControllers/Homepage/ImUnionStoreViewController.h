//
//  ImUnionStoreViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/20.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"

@interface ImUnionStoreViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *unionBalance;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *allIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *dealNumLab;


@property (weak, nonatomic) IBOutlet UIView *storeControlView;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UIView *checkStandView;
@property (weak, nonatomic) IBOutlet UIView *myMemView;
@property (weak, nonatomic) IBOutlet UIView *myBCardView;




@end
