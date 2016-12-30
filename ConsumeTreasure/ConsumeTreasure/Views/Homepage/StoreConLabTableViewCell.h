//
//  StoreConLabTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UpPikerViewBlock)();
@interface StoreConLabTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (nonatomic ,copy) UpPikerViewBlock pikerBlock;


@end
