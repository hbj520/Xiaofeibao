
//
//  DaLiViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/19.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "DaLiViewController.h"
#import "CashViewController.h"

#import "CHSocialService.h"

#import "StoreMasterModel.h"
#import "CheckstandViewController.h"
#import "ShareQRCodeViewController.h"
#import "AtractInvestViewController.h"
#import "WithDrawViewController.h"
@interface DaLiViewController ()
{
    DaLiMasterModel *daliModel;
    
    NSString *dayIncome;//今日收益余额
    NSString *allIncome;//历史
    
    NSString *canGetMoney;
    
    NSString *memIdStr;
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
    memIdStr = [[XFBConfig Instance]getmemId];
}


- (void)addGes{
    UITapGestureRecognizer *tapStore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(storeClick:)];
    [self.myStoreListView addGestureRecognizer:tapStore];
    
    UITapGestureRecognizer *tapGo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goClick:)];
    [self.goGetStoreDoorView addGestureRecognizer:tapGo];
    
    UITapGestureRecognizer *tapIncome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeClick:)];
    [self.incomeView addGestureRecognizer:tapIncome];
    
    UITapGestureRecognizer *tapbankCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankClick:)];
    [self.myBCardView addGestureRecognizer:tapbankCard];
    
    UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareClick:)];
    [self.shareView addGestureRecognizer:tapShare];
    
    UITapGestureRecognizer *tapShareRegister = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareRegisterClick:)];
    [self.shareRegisterView addGestureRecognizer:tapShareRegister];
    
    UITapGestureRecognizer *tapAttractRegister = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAttractClick:)];
    [self.attractInverstmentView addGestureRecognizer:tapAttractRegister];
    
}

- (void)pushToNextWithIdentiField:(NSString*)identi sender:(id)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:identi sender:sender];
    
}
///点击招商按钮
- (void)shareAttractClick:(id)Ges{
    [self pushToNextWithIdentiField:@"InvestSegueId" sender:nil];
}
- (void)shareClick:(id)Ges{
    [[CHSocialServiceCenter shareInstance]shareTitle:@"智惠返邀您一起享优惠" content:@"扫码支付实时到账，商户提现秒到，万亿市场等您来享！" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:[NSString stringWithFormat:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@",memIdStr] controller:self completion:^(BOOL successful) {
        
    }];
}

- (void)bankClick:(id)Ges{
    [self pushToNextWithIdentiField:@"myBankCardSegue" sender:nil];
    
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
- (void)shareRegisterClick:(id)shareRegisterClick{
    [self pushToNextWithIdentiField:@"goshareSegue2" sender:memIdStr];
}
- (void)getData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getDaiLiMasterDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            daliModel = (DaLiMasterModel*)object;
            self.daliArea.text = daliModel.proxyname;
            canGetMoney = daliModel.balance;
            self.leftMoney.text =   [NSString stringWithFormat:@"%.2f",[daliModel.settlementing_money floatValue]];
//            daliModel.settlementing_money = @"100";
//            daliModel.shop_money = @"200" ;
//            self.allInMoney.text = [NSString stringWithFormat:@"%.3f",[daliModel.settlementing_money floatValue]];
//            self.currentMonthMoney.text = [NSString stringWithFormat:@"%.3f",[daliModel.shop_money floatValue]];
//            dayIncome = [NSString stringWithFormat:@"%.3f",daliModel.today_withdrawal.floatValue];;
//            allIncome = [NSString stringWithFormat:@"%.3f",daliModel.history_withdrawal.floatValue];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
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
 */
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"DLTXsegue"]) {
//         NSArray *arr = (NSArray*)sender;
//         CashViewController *cashVC = segue.destinationViewController;
//         cashVC.incomeMoney = arr;
         WithDrawViewController *cashVC = segue.destinationViewController;
         
         cashVC.moneyType = @[(daliModel.settlementing_money != nil) ? daliModel.settlementing_money : @"0.00",@"2"];
         
     }else if ([segue.identifier isEqualToString:@"goshareSegue2"]){
         NSString *memStr = sender;
         ShareQRCodeViewController *shareVC = segue.destinationViewController;
         shareVC.memId = memStr;
     }
     
}


@end
