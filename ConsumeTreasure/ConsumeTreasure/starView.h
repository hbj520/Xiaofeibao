//
//  starView.h
//  poorTourist
//
//  Created by applehbj on 15/4/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface starView : UIView
-(id)initWithFrame:(CGRect)frame withStarLevel:(float)levels;
- (void)configWithStarLevel:(float)levels;
@end
