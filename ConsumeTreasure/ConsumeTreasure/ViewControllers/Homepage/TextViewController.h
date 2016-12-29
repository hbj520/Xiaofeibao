//
//  TextViewController.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^BackTextBlock) (NSString *str);
@interface TextViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic,copy) BackTextBlock textBlock;

@end
