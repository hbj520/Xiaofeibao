//
//  DetailHeadView.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/9.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeImgBlock)();

@interface DetailHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (nonatomic,copy) ChangeImgBlock imgBlock;

@end
