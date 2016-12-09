//
//  ImageTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef void (^indexBlock)(NSInteger index);

@interface ImageTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdcycleView;


@property (nonatomic,retain) NSMutableArray *addArray;

@property (nonatomic,copy) indexBlock indexBlock;
@end
