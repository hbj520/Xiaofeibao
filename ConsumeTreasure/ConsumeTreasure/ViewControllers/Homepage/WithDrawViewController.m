//
//  WithDrawViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/27.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "WithDrawViewController.h"
#import "MyBankCardViewController.h"
#import <Masonry.h>


@interface WithDrawViewController ()<XWMoneyTextFieldLimitDelegate>
{
    XWMoneyTextField *Tongtf;
    
    
    NSMutableArray *_cardList;
}

@end

@implementation WithDrawViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self judgeBankCard];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _cardList = [NSMutableArray array];
    
    [self setTextField];
    [self judgeBankCard];
    
    self.leftMoney.text = [NSString stringWithFormat:@"可提现余额为%@元",self.canGetMoney];
}

- (void)judgeBankCard{
    NSDictionary *para = @{
                           
                           };
    [[MyAPI sharedAPI] getMyBankCardDataWithParameters:para result:^(BOOL success, NSString *msg, NSArray *arrays) {
        
        if (success) {
            [_cardList removeAllObjects];
            _cardList = arrays[0];
            if (_cardList.count > 0) {
                bankCardModel *model = _cardList[0];
                self.defaultBank.text = model.bankname;
                self.defaultBankNum.text = [NSString stringWithFormat:@"尾号%@",model.bankno];
                self.defaultCardType.text = @"储蓄卡";
            }else{
               
                [self gotoAddBankCard];
                
                
            }
        }else{
            if ([msg isEqualToString:@"-1"]) {
                [Tools logoutWithNowVC:self];
            }
        }
        
    
    } errorResult:^(NSError *enginerError) {
        
    }];

}


- (void)gotoAddBankCard{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"尚未设置银行卡，请前往添加。" preferredStyle:1];
    UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"前往添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
        
        [self performSegueWithIdentifier:@"goAddBankCardSegue" sender:nil];
        
        
    }];
    [alertCon addAction:goAction];
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)setTextField{
    CGRect frame = CGRectMake(50,40,[UIScreen mainScreen].bounds.size.width - 100,40);
    Tongtf = [[XWMoneyTextField alloc] initWithFrame:frame];
    Tongtf.textAlignment = UITextAlignmentLeft;
    Tongtf.font = [UIFont systemFontOfSize:25];
    Tongtf.tintColor= [UIColor redColor];
    Tongtf.textColor = [UIColor redColor];
    Tongtf.placeholder = @"请输入金额";
    Tongtf.keyboardType = UIKeyboardTypeDecimalPad;
    Tongtf.limit.delegate = self;
    Tongtf.limit.max = @"999999999.99";
    
    [self.withdrawView addSubview:Tongtf];
    
    [Tongtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
         make.left.equalTo(@50);
        make.right.equalTo(@(-10));
        make.top.equalTo(@35);
    }];
}

#pragma mark - XWMoneyTextFieldLimitDelegate
- (void)valueChange:(id)sender{
    
    if ([sender isKindOfClass:[XWMoneyTextField class]]) {
        
        XWMoneyTextField *tf = (XWMoneyTextField *)sender;
        
        if (tf.text.floatValue < 1000) {
            self.chargeNum.text = @"提现手续费为0.5元";
        }else{
            self.chargeNum.text = @"提现手续费为0元";
        }
        

    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self backTolastPage];
}

- (IBAction)chooseBankClick:(id)sender {
    [self performSegueWithIdentifier:@"goBankSegue" sender:@"1"];
}

- (IBAction)getAllLeftMoney:(id)sender {

    NSLog(@"%@",self.canGetMoney);
    Tongtf.text = self.canGetMoney;
}


- (IBAction)getMoneyNow:(id)sender {
    NSLog(@"立即提现");
    
    if (Tongtf.text.floatValue > 0) {
        
        NSDictionary *para =@{
                              @"total_fee":Tongtf.text,
                              @"trade_type":@"",
                              @"bankid":@"",
                              @"zfpass":@""
                              
                              };
        
        
        
    }else{
        showAlert(@"请确认提现额度不为0");
    }
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"goBankSegue"]) {
        NSString *str = (NSString*)sender;
        MyBankCardViewController *bankVC = segue.destinationViewController;
        bankVC.type = str;
        
        bankVC.bankBlock =^(bankCardModel *model){
            self.defaultBank.text = model.bankname;
            self.defaultBankNum.text = [NSString stringWithFormat:@"尾号%@",model.bankno];
            self.defaultCardType.text = @"储蓄卡";
        };
        
    }
    
    
}


@end
