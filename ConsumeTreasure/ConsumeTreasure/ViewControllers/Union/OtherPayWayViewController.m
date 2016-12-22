//
//  OtherPayWayViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "OtherPayWayViewController.h"

@interface OtherPayWayViewController ()
{
    NSInteger payType;
}

@end

@implementation OtherPayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self choosePayWay];
}

- (void)choosePayWay{
    self.aliBtn.selected = YES;
    [self.aliBtn setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.aliBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [self.aliBtn addTarget:self action:@selector(choosePayWayClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.wxBtn.selected = NO;
    [self.wxBtn setBackgroundImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
    [self.wxBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [self.wxBtn addTarget:self action:@selector(choosePayWayClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)choosePayWayClick:(UIButton*)button{
    if (button.tag == 666) {
        self.aliBtn.selected = YES;
        self.wxBtn.selected = NO;
    }else{
        self.aliBtn.selected = NO;
        self.wxBtn.selected = YES;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}
- (IBAction)paySure:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
