//
//  ListHeadView.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/11/10.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
@interface ListHeadView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *listHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *listTitle;

@property (weak, nonatomic) IBOutlet UILabel *zanwuLab;


@end
