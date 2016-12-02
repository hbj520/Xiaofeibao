//
//  ProvinceHeadView.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JustBlock)();
@interface ProvinceHeadView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *provinceName;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,copy) JustBlock openBlock;

@end
