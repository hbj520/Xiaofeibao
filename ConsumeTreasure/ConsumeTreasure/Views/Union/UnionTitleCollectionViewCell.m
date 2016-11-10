//
//  UnionTitleCollectionViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 10/21/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "UnionTitleCollectionViewCell.h"
@interface UnionTitleCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowImageView;

@end
@implementation UnionTitleCollectionViewCell
- (void)configTitleText:(NSString *)titleText{
    self.titleLabel.text = titleText;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self registerNotification];
}
- (void)setCellIsSelected:(BOOL)CellIsSelected{
    _CellIsSelected = CellIsSelected;
    if (CellIsSelected) {
        self.downArrowImageView.transform = CGAffineTransformMakeRotation(0);
    }else{
        self.downArrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
}
- (void)registerNotification{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(arrowAct:) name:@"arrowNotification" object:nil];
}
- (void)arrowAct:(NSNotification *)notification{
    NSIndexPath *indexPath = notification.userInfo[@"indexpath"];
    if (self.indexPath != indexPath) {
        self.CellIsSelected = NO;
    }
    
}
- (void)dealloc{
   NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification removeObserver:self name:@"arrowNotification" object:nil];
}
@end
