//
//  ImUnionStoreViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/10/20.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "StoreMasterModel.h"
#import "ImUnionStoreViewController.h"
#import "CashViewController.h"
#import "CheckstandViewController.h"
#import "CHSocialService.h"
#import "ShareQRCodeViewController.h"
#import "MyMemberViewController.h"
@interface ImUnionStoreViewController ()
{
    StoreMasterModel *StoreMmodel;
    
    NSString *dayStr;
    NSString *allStr;
    
    NSString *memIdStr;
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
    memIdStr = [[XFBConfig Instance]getmemId];
}
#pragma mark -PrivateMethod
- (void)addGes{
    UITapGestureRecognizer *tapStore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(storeClick:)];
    [self.storeControlView addGestureRecognizer:tapStore];
    
    UITapGestureRecognizer *tapOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderClick:)];
    [self.orderView addGestureRecognizer:tapOrder];
    
    UITapGestureRecognizer *tapMem = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myMemClick:)];
    [self.myMemView addGestureRecognizer:tapMem];
    
    UITapGestureRecognizer *tapCheck = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkClick:)];
    [self.checkStandView addGestureRecognizer:tapCheck];
    
    UITapGestureRecognizer *tapCard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cardClick:)];
    [self.myBCardView addGestureRecognizer:tapCard];
    
    UITapGestureRecognizer *tapIncome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeClick:)];
    [self.incomeView addGestureRecognizer:tapIncome];
    
    UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareClick:)];
    [self.shareView addGestureRecognizer:tapShare];
    
    UITapGestureRecognizer *tapShareRegister = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareRegisterClick:)];
    [self.shareRegisterView addGestureRecognizer:tapShareRegister];

}



- (void)pushToNextWithIdentiField:(NSString*)identi sender:(id)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:identi sender:sender];
    
}
- (void)shareRegisterClick:(id)ges{
    [self pushToNextWithIdentiField:@"goshareSegue" sender:memIdStr];

}
- (void)shareClick:(id)Ges{
    [[CHSocialServiceCenter shareInstance]shareTitle:@"智惠返邀您一起享优惠" content:@"扫码支付实时到账，商户提现秒到，万亿市场等您来享！" imageURL:@"http://p2pguide.sudaotech.com/platform/image/1/20160318/3c896c87-65b6-481d-81ca-1b4a0b6d8dd4/" image:[UIImage imageNamed:@"qrImg"] urlResource:[NSString stringWithFormat:@"http://www.xftb168.com/web/toWxRegister?merchantMemId=%@",memIdStr] controller:self completion:^(BOOL successful) {
        
    }];
}

- (void)incomeClick:(id)Ges{
    [self pushToNextWithIdentiField:@"shuanghuIncomeSegue" sender:nil];
    
}

- (void)cardClick:(id)Ges{
    [self pushToNextWithIdentiField:@"myBankCardSegue" sender:nil];
    
}

- (void)storeClick:(id)Ges{
    [self pushToNextWithIdentiField:@"goStoreControlSegue" sender:nil];

}

- (void)orderClick:(id)Ges{
    
    [self pushToNextWithIdentiField:@"goOrderSegue" sender:nil];

}

- (void)myMemClick:(id)Ges{
 
    [self pushToNextWithIdentiField:@"goMyMemSegue" sender:@"1"];

}

- (void)checkClick:(id)Ges{
   // showAlert(@"敬请期待");
    [self pushToNextWithIdentiField:@"goCheckStandSegue" sender:@[StoreMmodel.memid,StoreMmodel.shopName]];

}

- (void)getData{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getStoreMasterDataWithParameters:para result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            StoreMmodel = object;
            self.unionBalance.text = [NSString stringWithFormat:@"总余额 : %.3f",StoreMmodel.total_money.floatValue];
            //settlementing_money
            self.dealNumLab.text =  [NSString stringWithFormat:@"%.3f",StoreMmodel.settlementing_money.floatValue];
            self.allIncomeLab.text = [NSString stringWithFormat:@"%.3f",StoreMmodel.withdrawal_money.floatValue];
            self.shopName.text = StoreMmodel.shopName;
            dayStr = [NSString stringWithFormat:@"%.3f",StoreMmodel.settlementing_money.floatValue];;
            allStr = [NSString stringWithFormat:@"%.3f",StoreMmodel.withdrawal_money.floatValue];
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [self logout];
            }
        }

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
    [self pushToNextWithIdentiField:@"SHTXsegue" sender:@[dayStr,allStr]];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */
#pragma mark - SegueMethod
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SHTXsegue"]) {
        NSArray *arr = (NSArray*)sender;
        CashViewController *cashVC = segue.destinationViewController;
        cashVC.incomeMoney = arr;
    }else if ([segue.identifier isEqualToString:@"goCheckStandSegue"]){
        CheckstandViewController *checkVC = segue.destinationViewController;
        NSArray *array = sender;
            checkVC.memId = (NSString *)array[0];
            checkVC.storeName = (NSString *)array[1];
    }else if ([segue.identifier isEqualToString:@"goshareSegue"]){
        NSString *medId = (NSString *)sender;
        ShareQRCodeViewController *qrVC = segue.destinationViewController;
        qrVC.memId = medId;
    }else if ([segue.identifier isEqualToString:@"goMyMemSegue"]){
        NSString *ismem = sender;
        MyMemberViewController *myMemberVC = segue.destinationViewController;
        myMemberVC.isMember = ismem.boolValue;
    }
    
}


@end
