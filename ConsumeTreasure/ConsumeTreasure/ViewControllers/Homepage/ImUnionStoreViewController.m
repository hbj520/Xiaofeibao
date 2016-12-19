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
     [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(241, 241, 241, 1);
    [self getData];
    [self addGes];
}

- (void)addGes{
    UITapGestureRecognizer *tapStore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(storeClick:)];
    [self.storeControlView addGestureRecognizer:tapStore];
    
    UITapGestureRecognizer *tapOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderClick:)];
    [self.orderView addGestureRecognizer:tapOrder];
    
    UITapGestureRecognizer *tapMem = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myMemClick:)];
    [self.myMemView addGestureRecognizer:tapMem];
    
    UITapGestureRecognizer *tapCheck = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkClick:)];
    [self.checkStandView addGestureRecognizer:tapCheck];
    
    
}

- (void)pushToNextWithIdentiField:(NSString*)identi sender:(id)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:identi sender:sender];
    
}

- (void)storeClick:(id)Ges{
    [self pushToNextWithIdentiField:@"goStoreControlSegue" sender:nil];

}

- (void)orderClick:(id)Ges{
    
    [self pushToNextWithIdentiField:@"goOrderSegue" sender:nil];

}

- (void)myMemClick:(id)Ges{
 
    [self pushToNextWithIdentiField:@"goMyMemSegue" sender:nil];

}

- (void)checkClick:(id)Ges{
    [self pushToNextWithIdentiField:@"goCheckStandSegue" sender:nil];

}

- (void)getData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getStoreMasterDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        
        StoreMmodel = object;
        self.unionBalance.text = [NSString stringWithFormat:@"余额 : %@",StoreMmodel.money];
        self.dealNumLab.text = StoreMmodel.total;
        self.allIncomeLab.text = StoreMmodel.turnover;
        self.shopName.text = StoreMmodel.shopName;
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
