//
//  ProvinceHeadView.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ProvinceHeadView.h"

@interface ProvinceHeadView()
@property (nonatomic,assign) BOOL isExpanded;

@end

@interface ZYButton : UIButton
@property(nonatomic,assign)int markIndex;//标记按钮所在的区号
@end

@implementation ZYButton
@end


@implementation ProvinceHeadView


- (IBAction)openClick:(id)sender {
    self.openBlock();
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
