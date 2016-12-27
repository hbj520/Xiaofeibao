//
//  ChangeHeadView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/11.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ChangeHeadView.h"

@implementation ChangeHeadView

- (void)awakeFromNib
{
    //self.frame = CGRectMake(0, 0, ScreenWidth - 36, 160);
    
    [self.btn1 addTarget:self action:@selector(btnclick1) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btnclick2) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect newframe1 = self.backView.frame;
    newframe1.size.width = ScreenWidth - 108;
    self.backView.frame = newframe1;
    
    CGRect newframe2 = self.btn1.frame;
    newframe2.size.width = ScreenWidth - 108;
    self.btn1.frame = newframe2;
    
    CGRect newframe3 = self.btn2.frame;
    newframe3.size.width = ScreenWidth - 108;
    self.btn2.frame = newframe3;

}

- (void)btnclick1
{
    if(self.LibraryBlock){
        self.LibraryBlock();
    }
}

- (void)btnclick2
{
    if(self.TakeBlock){
        self.TakeBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
