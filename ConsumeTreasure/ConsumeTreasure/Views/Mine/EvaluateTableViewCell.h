//
//  EvaluateTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 11/22/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickBtnBlock)();
@interface EvaluateTableViewCell : UITableViewCell
@property (copy,nonatomic) clickBtnBlock clickOneMoreBlock;
@property (copy,nonatomic) clickBtnBlock clickEvaluateBlock;
@end