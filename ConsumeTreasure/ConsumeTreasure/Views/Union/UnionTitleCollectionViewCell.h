//
//  UnionTitleCollectionViewCell.h
//  ConsumeTreasure
//
//  Created by youyou on 10/21/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UnionTitleCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) BOOL CellIsSelected;
- (void)configTitleText:(NSString *)titleText;
@end
