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
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UIView *partnerStoreView;
@property(nonatomic,copy)TapViewBlock scanBlock;
@property(nonatomic,copy)TapViewBlock accountBlock;
@property(nonatomic,copy)TapViewBlock recordBlock;
@property(nonatomic,copy)TapViewBlock incomeBlock;

@end
