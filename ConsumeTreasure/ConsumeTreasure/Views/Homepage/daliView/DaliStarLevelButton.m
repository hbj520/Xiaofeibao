//
//  DaliStarLevelButton.m
//  ConsumeTreasure
//
//  Created by apple on 2017/9/15.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import "DaliStarLevelButton.h"

@implementation DaliStarLevelButton

+ (DaliStarLevelButton *)loadNibView{
    UINib *nib = [UINib nibWithNibName:@"DaliStarLevelButton" bundle:nil];
    DaliStarLevelButton *button = [nib instantiateWithOwner:nil options:nil].lastObject;
    return button;
}


@end
