//
//  ViewController.m
//  oo
//
//  Created by youyoumacmini3 on 16/11/16.
//  Copyright © 2016年 youyoumacmini3. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *tmpArray1;
    NSMutableArray *tmpArray2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tmpArray1 = [self getArrayWithType:@"SarlaryRange"];
    tmpArray2 = [self getArrayWithType:@"WorkAge"];
    
 
    NSLog(@"%@-----------",tmpArray1);
}

- (NSMutableArray *)getArrayWithType:(NSString *)type {
    NSString *action = [NSString stringWithFormat:@"update%@Action", type];
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    SEL sel = NSSelectorFromString(action);
    if ([self respondsToSelector:sel]) {
        tmpArray = [self performSelector:sel];
    }
    return tmpArray;
}

- (NSArray *)updateSarlaryRangeAction {
    NSArray *array = @[@"不限",@"3k~5K",@"5k~10k",@"10k~20k",@"20k~30k"];
    return array;
}
- (NSArray *)updateWorkAgeAction {
    NSArray *array = @[ @"不限", @"1年以下", @"1~3年", @"3~5年", @"5~10年" ];
    return array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
