//
//  TongbaoMoneyView.h
//  ConsumeTreasure
//
//  Created by youyou on 10/18/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TongbaoMoneyView : UIView
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIButton *enableSeeButton;
@property (nonatomic,copy) NSString *money;
- (id)initWithFrame:(CGRect)frame money:(float)money;
@end
