//
//  DaliStarLevelButton.h
//  ConsumeTreasure
//
//  Created by apple on 2017/9/15.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaliStarLevelButton : UIControl
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

+ (DaliStarLevelButton *)loadNibView;
@end
