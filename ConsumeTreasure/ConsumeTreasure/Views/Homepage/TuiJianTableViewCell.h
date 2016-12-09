//
//  TuiJianTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/8.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnionContenModel.h"
#define tableViewContentReuseId @"tableviewReuseId"
#import "starView.h"

#import "TuiJianModel.h"

@interface TuiJianTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeImg;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLa;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *pointLab;
@property (weak, nonatomic) IBOutlet UILabel *diatanceLab;
@property (weak, nonatomic) IBOutlet starView *starV;


@property (nonatomic,strong) TuiJianModel *tuiModel;
- (void)configWithData:(UnionContenModel *)data;

@end
