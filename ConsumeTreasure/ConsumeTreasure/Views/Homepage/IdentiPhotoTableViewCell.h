//
//  IdentiPhotoTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PhotoBlock) ();
@interface IdentiPhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *onePhoto;
@property (weak, nonatomic) IBOutlet UIButton *twoPhoto;

@property (nonatomic,copy) PhotoBlock oneBlock;
@property (nonatomic,copy) PhotoBlock twoBlock;
@end
