//
//  LocationViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^LocationBlock)(NSArray *arr);
@interface LocationViewController : BaseViewController

@property (nonatomic,copy) LocationBlock locaBlock;

@property (weak, nonatomic) IBOutlet UILabel *cityNowLab;
@property (weak, nonatomic) IBOutlet UIButton *caityNowBtn;

@property (nonatomic,strong) NSString *locaStr;


@end
