//
//  HBJJpullButton.m
//  ConsumeTreasure
//
//  Created by youyou on 2017/8/21.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "HBJJpullButton.h"
@interface HBJJpullButton()


@end
@implementation HBJJpullButton

+ (HBJJpullButton *)loadNib{
    UINib *nib = [UINib nibWithNibName:@"HBJJpullButton" bundle:nil];
    HBJJpullButton *btn = [nib instantiateWithOwner:nil options:nil].lastObject;
    return btn;
}


@end
