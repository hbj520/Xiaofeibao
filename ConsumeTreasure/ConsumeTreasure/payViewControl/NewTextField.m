//
//  NewTextField.m
//  支付
//
//  Created by zhou on 16/10/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "NewTextField.h"

@implementation NewTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 禁止粘贴，选中，全选功能
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {//禁止粘贴
        return NO;
    }
    if (action == @selector(select:)) {//禁止选中
        return NO;
    }
    if (action == @selector(selectAll:)) {//禁止全选
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}


@end
