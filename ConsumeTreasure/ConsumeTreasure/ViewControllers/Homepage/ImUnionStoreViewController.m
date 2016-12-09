//
//  ImUnionStoreViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/20.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "StoreMasterModel.h"
#import "ImUnionStoreViewController.h"

@interface ImUnionStoreViewController ()
{
    StoreMasterModel *StoreMmodel;
}
@end

@implementation ImUnionStoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(241, 241, 241, 1);
    [self getData];
}

- (void)getData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getStoreMasterDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        
        StoreMmodel = object;
        self.unionBalance.text = [NSString stringWithFormat:@"余额 : %@",StoreMmodel.money];
        self.dealNumLab.text = StoreMmodel.total;
        self.allIncomeLab.text = StoreMmodel.turnover;
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)getMoney:(id)sender {
    //申请提现
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
