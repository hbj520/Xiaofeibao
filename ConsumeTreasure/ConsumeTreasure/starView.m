//
//  starView.m
//  poorTourist
//
//  Created by applehbj on 15/4/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "starView.h"
#import <Masonry.h>
@implementation starView
-(id)initWithFrame:(CGRect)frame withStarLevel:(float)levels
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configWithStarLevel:levels];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
}
- (void)configWithStarLevel:(float)levels{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
        self.backgroundColor = [UIColor clearColor];
        CGRect frame = self.frame;
        frame.size.width = 68;
        frame.size.height = 16;
        self.frame = frame;
        CGFloat with = frame.size.width/5;
        //创建底部空星星
        UIImageView *emptyStar = [[UIImageView alloc] initWithFrame:self.bounds];
        emptyStar.image = [UIImage imageNamed:@"starbggroud"];
        [self addSubview:emptyStar];
        //截取浮点取整
        int cout = (int)levels;
        for (int i = 0; i < cout ; i++)
        {
            UIImageView *wholeStar = [[UIImageView alloc] initWithFrame:CGRectMake(with*i, 0, with, frame.size.height)];
            wholeStar.image = [UIImage imageNamed:@"star_light"];
            [self addSubview:wholeStar];
        }
        if (cout - levels < 0)
        {
            UIImageView *halfStar = [[UIImageView alloc] initWithFrame:CGRectMake(with*cout, 0, with, frame.size.height)];
            halfStar.image = [UIImage imageNamed:@"star_light"];
            [self addSubview:halfStar];
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
