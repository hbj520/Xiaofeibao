//
//  HomeListHeadView.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^gotoSecBlock)();

@interface HomeListHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;


@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (nonatomic,copy) gotoSecBlock goBlock;

@end
