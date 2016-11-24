//
//  ChangeRecStoreTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/22.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapViewBlock)();

@interface ChangeRecStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *oneName;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIView *oneView;

@property (weak, nonatomic) IBOutlet UILabel *twoName;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@property (weak, nonatomic) IBOutlet UILabel *threeName;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIView *threeView;

@property (nonatomic,copy) TapViewBlock oneBlock;
@property (nonatomic,copy) TapViewBlock twoBlock;
@property (nonatomic,copy) TapViewBlock threeBlock;

@property (nonatomic,strong) NSMutableArray *storeArray;

@end
