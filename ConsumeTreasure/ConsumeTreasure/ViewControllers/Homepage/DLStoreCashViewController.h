//
//  DLStoreCashViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/3/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "BaseViewController.h"

@interface DLStoreCashViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (nonatomic,copy) NSString *memId;

@end
