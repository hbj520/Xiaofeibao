//
//  ApplyContentTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)();
typedef void(^tfBlock)(NSString *);

@interface ApplyContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *trueName;
@property (weak, nonatomic) IBOutlet UITextField *identiNum;
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UITextField *rangeText;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *storeAddrText;


@property (weak, nonatomic) IBOutlet UIButton *goPositon;
@property (weak, nonatomic) IBOutlet UIButton *chooseRange;

@property (nonatomic,copy)BtnBlock chooseBlock;
@property (nonatomic,copy)BtnBlock positionBlock;

@property (nonatomic,copy)tfBlock trueNameBlock;
@property (nonatomic,copy)tfBlock identiNumBlock;
@property (nonatomic,copy)tfBlock storeNameBlock;
@property (nonatomic,copy)tfBlock phoneTextBlock;
@property (nonatomic,copy)tfBlock storeAddrTextBlock;
@property (nonatomic,copy)tfBlock inviteCodeTextBlock;

@end
