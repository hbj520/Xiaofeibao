//
//  PreEvaluateTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 11/23/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
typedef void (^ClickStarsBlock)();
#define PreEvaluteReuseId @"preEvaluateReuseId"
@interface PreEvaluateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet starView *evaluateStarView;
@property (copy, nonatomic) ClickStarsBlock clickStarBlock;
@property (strong, nonatomic) UITextView *desTextView;

@end
