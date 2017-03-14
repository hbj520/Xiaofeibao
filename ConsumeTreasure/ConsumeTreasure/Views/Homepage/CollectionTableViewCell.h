//
//  CollectionTableViewCell.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/3/14.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectShopListModel.h"

typedef void(^DeleBlock) ();

@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddr;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic,strong) CollectShopListModel *collectShopMo;

@property (nonatomic,copy) DeleBlock deleteBlock;

@end
