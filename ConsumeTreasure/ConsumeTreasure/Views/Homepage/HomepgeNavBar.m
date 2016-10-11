//
//  HomepgeNavBar.m
//  ConsumeTreasure
//
//  Created by youyou on 10/11/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "HomepgeNavBar.h"

@implementation HomepgeNavBar


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)awakeFromNib{
    [super awakeFromNib];
     [self createUI];
}
/*
- (void)drawRect:(CGRect)rect {
    
    [self createUI];
    // Drawing code
}
 */
- (void)createUI{
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    testView.backgroundColor = [UIColor redColor];
    self.titleView = testView;
    
}

@end
