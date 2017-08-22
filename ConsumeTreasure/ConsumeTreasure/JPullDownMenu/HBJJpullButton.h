//
//  HBJJpullButton.h
//  ConsumeTreasure
//
//  Created by youyou on 2017/8/21.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBJJpullButton : UIControl
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+ (HBJJpullButton *)loadNib;

@end
