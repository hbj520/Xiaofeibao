//
//  DaLiViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DaLiViewController.h"
#import "StoreMasterModel.h"
@interface DaLiViewController ()
{
    DaLiMasterModel *daliModel;
}

@end

@implementation DaLiViewController

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
    [self addGes];
    [self getData];
}


- (void)addGes{
    UITapGestureRecognizer *tapStore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(storeClick:)];
    [self.myStoreListView addGestureRecognizer:tapStore];
    
    UITapGestureRecognizer *tapGo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goClick:)];
    [self.goGetStoreDoorView addGestureRecognizer:tapGo];
    
    UITapGestureRecognizer *tapIncome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeClick:)];
    [self.incomeView addGestureRecognizer:tapIncome];
}

- (void)pushToNextWithIdentiField:(NSString*)identi sender:(id)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:identi sender:sender];
    
}

- (void)storeClick:(id)Ges{
    [self pushToNextWithIdentiField:@"myStoreListSegue" sender:nil];
    
}

- (void)goClick:(id)Ges{
    
    //[self pushToNextWithIdentiField:@"goOrderSegue" sender:nil];
    showAlert(@"正在开发，敬请期待");
}

- (void)incomeClick:(id)Ges{
    
    [self pushToNextWithIdentiField:@"incomeDetailSegue" sender:nil];
    
}

- (void)getData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getDaiLiMasterDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            daliModel = (DaLiMasterModel*)object;
            self.daliArea.text = daliModel.type;
            self.leftMoney.text = [NSString stringWithFormat:@"余额 : %@",daliModel.balance];
            self.allInMoney.text = [NSString stringWithFormat:@"%.2f",[daliModel.total_money floatValue]];
            self.currentMonthMoney.text = [NSString stringWithFormat:@"%.2f",[daliModel.month_money floatValue]];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (IBAction)getMoney:(id)sender {
    NSLog(@"提现");
    
    [self pushToNextWithIdentiField:@"DLTXsegue" sender:nil];

}


- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
