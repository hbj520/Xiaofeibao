//
//  HomePageFirstTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/12.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapViewBlock) ();
@interface HomePageFirstTableViewCell : UITableViewCell

@property(nonatomic,copy)TapViewBlock scanBlock;
@property(nonatomic,copy)TapViewBlock accountBlock;
@property(nonatomic,copy)TapViewBlock recordBlock;
@property(nonatomic,copy)TapViewBlock incomeBlock;

@end
