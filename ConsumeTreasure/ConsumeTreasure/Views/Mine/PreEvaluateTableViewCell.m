//
//  PreEvaluateTableViewCell.m
//  ConsumeTreasure
//
//  Created by youyou on 11/23/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "PreEvaluateTableViewCell.h"

@implementation PreEvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createUI];
    [self addTapGes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)createUI{
    self.desTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 103, ScreenWidth-100, 50)];
    [self.evaluateStarView configWithStarLevel:0];
    self.desTextView.text = @"请您对商家有什么建议和意见吗^-^";
    self.desTextView.textColor = [UIColor lightGrayColor];
    
    
}
- (void)addTapGes{
   UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatestar:)];
    [self.evaluateStarView addGestureRecognizer:tap];
}
- (void)updatestar:(UITapGestureRecognizer *)sender
{
    [self addSubview:self.desTextView];
  

    CGPoint point = [sender locationInView:self.evaluateStarView];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/self.evaluateStarView.bounds.size.width;
    if(scale<0.1){
        starnumber = 0;
    }else{
        starnumber = scale * 5+1;
    }
    if (self.frame.size.height != 200) {
        if (self.clickStarBlock) {
            self.clickStarBlock(starnumber);
        }
    }
    [self.evaluateStarView configWithStarLevel:starnumber];
}
@end
